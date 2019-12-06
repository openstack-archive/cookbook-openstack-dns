task default: ['test']

task test: [:lint, :style, :unit]

desc 'Vendor the cookbooks in the Berksfile'
task :berks_prep do
  sh %(chef exec berks vendor)
end

desc 'Run FoodCritic (lint) tests'
task :lint do
  sh %(chef exec foodcritic --epic-fail any --tags ~FC003 --tags ~FC023 .)
end

desc 'Run RuboCop (style) tests'
task :style do
  sh %(chef exec cookstyle)
end

desc 'Run RSpec (unit) tests'
task unit: :berks_prep do
  sh %(chef exec rspec --format documentation)
end

desc 'Remove the berks-cookbooks directory and the Berksfile.lock'
task :clean do
  rm_rf [
    'berks-cookbooks',
    'Berksfile.lock',
  ]
end

desc 'All-in-One Neutron build Infra using Common task'
task :integration do
  # Use the common integration task
  sh %(wget -nv -t 3 -O https://opendev.org/openstack/cookbook-openstack-common/raw/branch/master/Rakefile)
  load './Rakefile-Common'
  Rake::Task['common_integration'].invoke
end
