require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'
require 'securerandom'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.log_level = :warn
  config.file_cache_path = '/var/chef/cache'
end

REDHAT_OPTS = {
  platform: 'redhat',
  version: '7',
}.freeze
UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '18.04',
}.freeze

shared_context 'dns-stubs' do
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:rabbit_transport_url)
      .with('dns')
      .and_return('rabbit://guest:mypass@127.0.0.1:5672')
    allow_any_instance_of(Chef::Recipe).to receive(:rabbit_servers)
      .and_return '1.1.1.1:5672,2.2.2.2:5672'
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('db', 'designate')
      .and_return('db-pass')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('service', 'openstack-dns')
      .and_return('designate-pass')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('token', 'designate_rndc')
      .and_return('rndc-key')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('user', 'admin')
      .and_return('admin')
  end
end

shared_context 'neutron-stubs' do
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('token', 'openstack_identity_bootstrap_token')
      .and_return('bootstrap-token')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('token', 'neutron_metadata_secret')
      .and_return('metadata-secret')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('db', anything)
      .and_return('neutron')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('service', 'openstack-network')
      .and_return('neutron-pass')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('user', 'guest')
      .and_return('mq-pass')
    allow(Chef::Application).to receive(:fatal!)
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('service', 'openstack-compute')
      .and_return('nova-pass')
    allow_any_instance_of(Chef::Recipe).to receive(:get_password)
      .with('user', 'admin')
      .and_return('admin-pass')
    allow_any_instance_of(Chef::Recipe).to receive(:rabbit_transport_url)
      .with('network')
      .and_return('rabbit://guest:mypass@127.0.0.1:5672')
  end
end
