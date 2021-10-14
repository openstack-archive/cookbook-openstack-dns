#
# Cookbook:: openstack-dns
# Recipe:: common
#
# Copyright:: 2017-2021, x-ion Gmbh
# Copyright:: 2019-2021, Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class ::Chef::Recipe
  include ::Openstack
end

include_recipe 'openstack-common'

if node['openstack']['dns']['syslog']['use']
  include_recipe 'openstack-common::logging'
end

platform_options = node['openstack']['dns']['platform']

package platform_options['designate_packages'] do
  options platform_options['package_overrides']
  action :upgrade
end

db_type = node['openstack']['db']['dns']['service_type']
package node['openstack']['db']['python_packages'][db_type] do
  action :upgrade
end

if node['openstack']['mq']['service_type'] == 'rabbit'
  node.default['openstack']['dns']['conf_secrets']['DEFAULT']['transport_url'] = rabbit_transport_url 'dns'
end

db_user = node['openstack']['db']['dns']['username']
db_pass = get_password 'db', 'designate'

bind_services = node['openstack']['bind_service']['all']
api_bind = bind_services['dns-api']
api_bind_str = "#{bind_address api_bind}:#{api_bind['port']}"

identity_endpoint = internal_endpoint 'identity'

# define attributes that are needed in designate.conf
node.default['openstack']['dns']['conf'].tap do |conf|
  conf['service:api']['listen'] = api_bind_str
  conf['keystone_authtoken']['auth_url'] = identity_endpoint.to_s
  conf['keystone_authtoken']['www_authenticate_uri'] = identity_endpoint.to_s
end

# define secrets that are needed in designate.conf
node.default['openstack']['dns']['conf_secrets'].tap do |conf_secrets|
  conf_secrets['storage:sqlalchemy']['connection'] =
    db_uri('dns', db_user, db_pass)
  conf_secrets['keystone_authtoken']['password'] =
    get_password 'service', 'openstack-dns'
end

# merge all config options and secrets to be used in designate.conf
designate_conf_options = merge_config_options 'dns'

directory '/etc/designate' do
  owner node['openstack']['dns']['user']
  group node['openstack']['dns']['group']
  mode '750'
end

template '/etc/designate/designate.conf' do
  source 'openstack-service.conf.erb'
  cookbook 'openstack-common'
  owner node['openstack']['dns']['user']
  group node['openstack']['dns']['group']
  mode '640'
  sensitive true
  variables(
    service_config: designate_conf_options
  )
end

# delete all secrets saved in the attribute
# node['openstack']['dns']['conf_secrets'] after creating the config file
ruby_block "delete all attributes in node['openstack']['dns']['conf_secrets']" do
  block do
    node.rm(:openstack, :dns, :conf_secrets)
  end
end

rndc_secret = get_password 'token', 'designate_rndc'
pool_config = node['openstack']['dns']['pool']

template pool_config['rndc_key'] do
  source 'rndc.key.erb'
  owner node['openstack']['dns']['user']
  group node['openstack']['dns']['group']
  sensitive true
  mode '440'
  variables(
    secret: rndc_secret
  )
end

template '/etc/designate/pools.yaml' do
  source 'pools.yaml.erb'
  owner node['openstack']['dns']['user']
  group node['openstack']['dns']['group']
  mode '644'
  variables(
    banner: node['openstack']['dns']['custom_template_banner'],
    bind_hosts: pool_config['bind_hosts'],
    masters: pool_config['masters'],
    ns_addresses: pool_config['ns_addresses'],
    ns_hostnames: pool_config['ns_hostnames'],
    rndc_key: pool_config['rndc_key']
  )
end

execute 'designate-manage database sync' do
  user node['openstack']['dns']['user']
  group node['openstack']['dns']['group']
  command 'designate-manage database sync'
  action :run
end

execute 'designate-manage pool update' do
  user node['openstack']['dns']['user']
  group node['openstack']['dns']['group']
  command 'designate-manage pool update'
  action :nothing
  subscribes :run, 'template[/etc/designate/pools.yaml]'
end
