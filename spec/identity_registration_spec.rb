require_relative 'spec_helper'

describe 'openstack-dns::identity_registration' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::SoloRunner.new(UBUNTU_OPTS) }
    let(:node) { runner.node }
    cached(:chef_run) do
      runner.converge(described_recipe)
    end

    include_context 'dns-stubs'

    it 'converges successfully' do
      expect { :chef_run }.to_not raise_error
    end

    connection_params = {
      openstack_api_key: 'admin',
      openstack_auth_url: 'http://127.0.0.1:5000/v3',
      openstack_domain_name: 'default',
      openstack_project_name: 'admin',
      openstack_username: 'admin',
    }

    it do
      expect(chef_run).to create_openstack_service('designate').with(
        type: 'dns',
        connection_params: connection_params
      )
    end

    it do
      expect(chef_run).to create_openstack_endpoint('dns').with(
        service_name: 'designate',
        interface: 'internal',
        url: 'http://127.0.0.1:9001',
        region: 'RegionOne',
        connection_params: connection_params
      )
    end

    it do
      expect(chef_run).to create_openstack_project('service').with(
        connection_params: connection_params
      )
    end

    it do
      expect(chef_run).to create_openstack_user('designate').with(
        role_name: 'service',
        project_name: 'service',
        domain_name: 'Default',
        password: 'designate-pass',
        connection_params: connection_params
      )
    end
  end
end
