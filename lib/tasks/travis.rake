task :travis do
  [
    'rspec spec --profile --color',
    'guard-jasmine --spec-dir spec/javascripts --server-timeout=60'
  ].each do |cmd|
    puts "Running #{cmd}..."
    system("bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end
