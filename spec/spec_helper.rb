require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

end

Spork.each_run do

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'factory_girl_rails'
  require 'shoulda'
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  Dir[Rails.root.join("lib/beech_server/*.rb")].each {|f| require f}

  # reload all factories
  FactoryGirl.factories.clear
  Dir.glob("#{::Rails.root}/spec/factories/*.rb").each do |file|
    load "#{file}"
  end

  I18n.default_locale = :en
  I18n.locale = :en

  RSpec.configure do |config|

    config.mock_with :mocha

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
    config.use_transactional_examples = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"

    config.before(:each) do
      Bullet.start_request if Bullet.enable?
    end

    config.after(:each) do
      if Bullet.enable?
        Bullet.perform_out_of_channel_notifications
        Bullet.end_request
      end
    end

  end

end

