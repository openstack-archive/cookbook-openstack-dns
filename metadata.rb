# encoding: UTF-8
name              'openstack-dns'
maintainer        'openstack-chef'
maintainer_email  'openstack-discuss@lists.openstack.org'
issues_url        'https://launchpad.net/openstack-chef'
source_url        'https://opendev.org/openstack/cookbook-openstack-dns'
license           'Apache-2.0'
description       'Installs and configures the Designate Service'
chef_version      '>= 15.0'
version           '19.0.0'

%w(ubuntu redhat centos).each do |os|
  supports os
end

depends 'openstackclient'
depends 'openstack-common', '>= 19.0.0'
depends 'openstack-identity', '>= 19.0.0'
depends 'openstack-network', '>= 19.0.0'
