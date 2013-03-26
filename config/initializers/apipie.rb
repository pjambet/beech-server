Apipie.configure do |config|
  config.app_name                = "BeechServer"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.markup = Apipie::Markup::Markdown.new
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/*.rb"
  config.copyright = "&copy; 2013 Pierre & Luc"
  config.app_info = "
    This is where you can inform user about your application and API
    in general."
end
