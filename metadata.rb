# encoding: UTF-8
name 'openstack-dns'
maintainer 'openstack-chef'
maintainer_email 'openstack-discuss@lists.openstack.org'
issues_url 'https://launchpad.net/openstack-chef'
source_url 'https://opendev.org/openstack/cookbook-openstack-dns'
license 'Apache-2.0'
description 'Installs and configures the Designate Service'
chef_version '>= 14.0'
version '18.0.0'

recipe 'api', 'Configure and start designate-api service'
recipe 'central', 'Starts and enables the designate-central service'
recipe 'common', 'Installs the designate packages and setup configuration for Designate.'
recipe 'dashboard', 'Installs the designate dashboard packages.'
recipe 'identity_registration', 'Registers the Designate API endpoint, designate service and user'
recipe 'mdns', 'Starts and enables the designate-mdns service'
recipe 'neutron_int', 'Configure the neutron external dns driver'
recipe 'producer', 'Starts and enables the designate-producer service'
recipe 'sink', 'Starts and enables the designate-sink service'
recipe 'worker', 'Starts and enables the designate-worker service'

%w(ubuntu redhat centos).each do |os|
  supports os
end

depends 'openstack-common', '>= 18.0.0'
depends 'openstack-identity', '>= 18.0.0'
depends 'openstackclient'
