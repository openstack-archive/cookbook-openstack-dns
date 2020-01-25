include_recipe 'openstack-dns::common'

platform_options = node['openstack']['dns']['platform']

service 'designate_sink' do
  service_name platform_options['designate_sink_service']
  supports status: true, restart: true
  action [:enable, :start]
  subscribes :restart, 'template[/etc/designate/designate.conf]'
end
