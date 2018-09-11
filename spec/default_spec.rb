describe 'default recipe on Ubuntu 16.04' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |node|
      node.automatic[:lsb][:codename] = 'xenial'
    end.converge('openstack-dns::default')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
