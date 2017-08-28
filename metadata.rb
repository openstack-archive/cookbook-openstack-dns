# encoding: UTF-8
name 'openstack-dns'
maintainer 'openstack-chef'
maintainer_email 'openstack-dev@lists.openstack.org'
issues_url 'https://launchpad.net/openstack-chef' if respond_to?(:issues_url)
source_url 'https://github.com/cloudbau/cookbook-openstack-dns' if respond_to?(:source_url)
license 'Apache 2.0'
description 'Installs and configures the Designate Service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '16.0.0'

%w(ubuntu redhat centos).each do |os|
  supports os
end

depends 'openstack-common', '>= 16.0.0'
depends 'openstack-identity', '>= 16.0.0'
depends 'openstackclient'
