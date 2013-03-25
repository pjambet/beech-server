$:.push File.expand_path("../../app/models", __FILE__)
$:.push File.expand_path("../../lib/beech_server", __FILE__)
$:.push File.expand_path("../../config/initializers", __FILE__)

require 'active_support'
require 'devise'
require 'factory_girl'
require 'vcr'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.expand_path("../", __FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  config.order = "random"

end

