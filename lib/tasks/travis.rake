task :travis do
  [
    'rspec spec --profile --color',
    'guard-jasmine --server-timeout=30 -s webrick -e development'
  ].each do |cmd|
    puts "Running #{cmd}..."
    system("bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end
