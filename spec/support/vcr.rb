VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  config.ignore_request do |request|
    request.uri =~ /coveralls/
  end
end
