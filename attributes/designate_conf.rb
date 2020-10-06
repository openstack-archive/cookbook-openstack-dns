#
# Cookbook:: openstack-dns
# Attributes:: default
#
# Copyright:: 2017, x-ion GmbH
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

default['openstack']['dns']['conf']['DEFAULT']['log_dir'] = '/var/log/designate'
default['openstack']['dns']['conf']['service:api']['auth_strategy'] = 'keystone'
default['openstack']['dns']['conf']['service:api']['enable_api_v1'] = 'True'
default['openstack']['dns']['conf']['service:api']['enabled_extensions_v1'] = 'quotas, reports'
default['openstack']['dns']['conf']['service:api']['enable_api_v2'] = 'True'
default['openstack']['dns']['conf']['service:worker']['enabled'] = 'True'
default['openstack']['dns']['conf']['service:worker']['notify'] = 'True'
default['openstack']['dns']['conf']['keystone_authtoken']['auth_type'] = 'password'
default['openstack']['dns']['conf']['keystone_authtoken']['username'] = 'designate'
default['openstack']['dns']['conf']['keystone_authtoken']['project_name'] = 'service'
default['openstack']['dns']['conf']['keystone_authtoken']['project_domain_name'] = 'Default'
default['openstack']['dns']['conf']['keystone_authtoken']['user_domain_name'] = 'Default'
default['openstack']['dns']['conf']['keystone_authtoken']['service_token_roles_required'] = 'True'
