require_relative 'spec_helper'

describe 'openstack-dns::neutron_int' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::SoloRunner.new(UBUNTU_OPTS) }
    let(:node) { runner.node }
    cached(:chef_run) do
      runner.converge(described_recipe, 'openstack-network')
    end

    include_context 'dns-stubs'
    include_context 'neutron-stubs'

    it 'converges successfully' do
      expect { :chef_run }.to_not raise_error
    end

    describe '/etc/neutron/neutron.conf' do
      it 'section: DEFAULT' do
        [
          /^external_dns_driver = designate$/,
        ].each do |line|
          expect(chef_run).to render_config_file('/etc/neutron/neutron.conf').with_section_content('DEFAULT', line)
        end
      end
      it 'section: designate' do
        [
          %r{^url = http://127.0.0.1:9001/v2$},
          /^auth_type = password$/,
          %r{^auth_url = http://127.0.0.1:5000/v3$},
          /^username = designate$/,
          /^project_name = service$/,
          /^project_domain_name = Default$/,
          /^user_domain_name = Default$/,
          /^password = designate-pass$/,
        ].each do |line|
          expect(chef_run).to render_config_file('/etc/neutron/neutron.conf').with_section_content('designate', line)
        end
      end
    end
  end
end
