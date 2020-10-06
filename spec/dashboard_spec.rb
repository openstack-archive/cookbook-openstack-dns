require_relative 'spec_helper'

describe 'openstack-dns::dashboard' do
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
      expect(chef_run).to upgrade_package('python3-designate-dashboard')
    end
  end
end
