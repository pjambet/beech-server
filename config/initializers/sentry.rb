if Rails.env.staging?
  Raven.configure do |config|
      config.current_environment = 'production'
  end
end
