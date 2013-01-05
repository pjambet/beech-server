# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
#
# old, probably compromised, open on GitHub
# BeerServer::Application.config.secret_token = '271a51cfdcdeaa9d4b3b69758194409b7d4684bad1fa5a16ec57c2a578c8fc84a3216cb2621d827d9ad9a79b3669c23eb2550fc647ea7c5a669d48225d613897'
begin
    token_file = Rails.root.to_s + "/secret_token"
    to_load = open(token_file).read
    BeerServer::Application.configure do
        config.secret_token = to_load
    end
rescue LoadError, Errno::ENOENT => e
    raise "Secret token couldn't be loaded! Error: #{e}"
end

