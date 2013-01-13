# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
#
# old, probably compromised, open on GitHub
# BeerServer::Application.config.secret_token = '271a51cfdcdeaa9d4b3b69758194409b7d4684bad1fa5a16ec57c2a578c8fc84a3216cb2621d827d9ad9a79b3669c23eb2550fc647ea7c5a669d48225d613897'
if secret_token = ENV['SECRET_TOKEN']
  # production env should define the secret token
  config.secret_token = secret_token
else
  # used for development
  config.secret_token = '9337470c9fdff55ca07e67299c279540487a023bdff5c1b46f01608fdc1677d1e41e407d44ad3c7ecc37b44bb414c8b04f9d1a1c214bbc070fa4f180e57221df'
end


