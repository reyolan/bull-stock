VCR.configure do |config|
  # cassette (HTTP Interactions directory)
  config.cassette_library_dir = "spec/cassettes"

  # hooks/talks to webmock
  config.hook_into :webmock

  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
end
