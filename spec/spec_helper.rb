require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'
unless ENV['DRB']
  require 'coveralls'
  Coveralls.wear!('rails')
end

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
  require 'vcr'

  if ENV['DRB']
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

    config.treat_symbols_as_metadata_keys_with_true_values = true

    # CarrierWave file deletion
    config.after(:all) do
      if Rails.env.test?
        FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
      end
    end

    if defined?(CarrierWave) && Rails.env.test?
      CarrierWave::Uploader::Base.descendants.each do |klass|
        next if klass.anonymous?
        klass.class_eval do
          def cache_dir
            "#{Rails.root}/spec/support/uploads/tmp"
          end

          def store_dir
            "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
          end
        end
      end
    end
  end
end

