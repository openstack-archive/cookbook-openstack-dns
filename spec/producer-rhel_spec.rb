# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-dns::producer' do
  describe 'redhat' do
    let(:runner) { ChefSpec::SoloRunner.new(REDHAT_OPTS) }
    let(:node) { runner.node }
    cached(:chef_run) do
      runner.converge(described_recipe)
    end

    include_context 'dns-stubs'

    it 'converges successfully' do
      expect { :chef_run }.to_not raise_error
    end
    it do
      expect(chef_run).to enable_service('designate_producer').with(
        service_name: 'designate-producer',
        supports: { restart: true, status: true }
      )
      expect(chef_run).to start_service('designate_producer')
    end
    it do
      expect(chef_run.service('designate_producer')).to \
        subscribe_to('template[/etc/designate/designate.conf]').on(:restart)
    end
  end
end
