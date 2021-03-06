require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module BeerServer
  class Application < Rails::Application

    config.time_zone = 'Paris'

    config.i18n.default_locale = :fr
    config.i18n.available_locales = [:en, :fr]

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/serializers/concerns)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.initialize_on_precompile = false

    config.action_controller.action_on_unpermitted_parameters = :log

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.cache_store = :dalli_store

    config.sass.line_comments = false
    config.sass.style = :nested
    config.assets.precompile += %w( admin.js admin.css )
  end
end
