#
# Cookbook:: openstack-dns
# Recipe:: identity_registration
#
# Copyright:: 2017, x-ion GmbH
# Copyright:: 2019-2020, Oregon State University
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

identity_endpoint = internal_endpoint 'identity'
auth_url = identity_endpoint.to_s

internal_designate_endpoint = internal_endpoint 'dns-api'
public_designate_endpoint = public_endpoint 'dns-api'

service_pass = get_password 'service', 'openstack-dns'
service_project_name = node['openstack']['dns']['conf']['keystone_authtoken']['project_name']
service_user = node['openstack']['dns']['conf']['keystone_authtoken']['username']
service_role = node['openstack']['dns']['service_role']
service_type = 'dns'
service_name = 'designate'
service_domain_name = node['openstack']['dns']['conf']['keystone_authtoken']['user_domain_name']
admin_user = node['openstack']['identity']['admin_user']
admin_pass = get_password 'user', node['openstack']['identity']['admin_user']
admin_project = node['openstack']['identity']['admin_project']
admin_domain = node['openstack']['identity']['admin_domain_name']
region = node['openstack']['region']

connection_params = {
  openstack_auth_url: auth_url,
  openstack_username: admin_user,
  openstack_api_key: admin_pass,
  openstack_project_name: admin_project,
  openstack_domain_name: admin_domain,
}

# Register DNS Service
openstack_service service_name do
  type service_type
  connection_params connection_params
end

# Register DNS Public-Endpoint
openstack_endpoint service_type do
  service_name service_name
  interface 'public'
  url public_designate_endpoint.to_s
  region region
  connection_params connection_params
end

# Register DNS Internal-Endpoint
openstack_endpoint service_type do
  service_name service_name
  interface 'internal'
  url internal_designate_endpoint.to_s
  region region
  connection_params connection_params
end

# Register Service Project
openstack_project service_project_name do
  connection_params connection_params
end

# Register Service User
openstack_user service_user do
  role_name service_role
  project_name service_project_name
  domain_name service_domain_name
  password service_pass
  connection_params connection_params
  action [:create, :grant_role]
end
