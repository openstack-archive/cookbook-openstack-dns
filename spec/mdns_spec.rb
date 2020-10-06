require_relative 'spec_helper'

describe 'openstack-dns::mdns' do
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
    it do
      expect(chef_run).to enable_service('designate_mdns').with(
        service_name: 'designate-mdns',
        supports: { restart: true, status: true }
      )
      expect(chef_run).to start_service('designate_mdns')
    end
    it do
      expect(chef_run.service('designate_mdns')).to \
        subscribe_to('template[/etc/designate/designate.conf]').on(:restart)
    end
  end
end
