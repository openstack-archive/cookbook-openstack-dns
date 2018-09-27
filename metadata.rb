# encoding: UTF-8
name 'openstack-dns'
maintainer 'openstack-chef'
maintainer_email 'openstack-dev@lists.openstack.org'
issues_url 'https://launchpad.net/openstack-chef' if respond_to?(:issues_url)
source_url 'https://git.openstack.org/openstack/cookbook-openstack-dns' if respond_to?(:source_url)
license 'Apache-2.0'
description 'Installs and configures the Designate Service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 12.5' if respond_to?(:chef_version)
version '17.0.2'

%w(ubuntu redhat centos).each do |os|
  supports os
end

depends 'openstack-common'
depends 'openstack-identity'
depends 'openstackclient'
