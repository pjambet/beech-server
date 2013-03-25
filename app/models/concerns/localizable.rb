module Localizable

  extend ActiveSupport::Concern

  included do
    def locate(lat, lng)
      res = client.search_venues ll: "#{lat},#{lng}", v: 20130225, categoryId: '4d4b7105d754a06376d81259', radius: 100
      res.venues.first
    end

    def client
      creds = OAUTH_CREDENTIALS[:foursquare]
      client = Foursquare2::Client.new(client_id: creds[:client_id], client_secret: creds[:client_secret])
    end

  end
end

