class Api::ApplicationController < ApplicationController
  before_filter :skip_trackable, :authenticate_user!

  def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

  resource_description do
    error code: 401, desc: "Unauthorized"
    error code: 404, desc: "Not Found"
  end
end
