class Api::ApplicationController < ApplicationController
  before_filter :skip_trackable, :authenticate_user!

  def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

  rescue_from Exception, with: (lambda do |exception|
    if Rails.application.config.consider_all_requests_local
      raise exception
    else
      # Raven.capture_exception(exception)
      raise exception
      render_error
    end
  end)

  def render_error
    render json: {error: 'An error occured'}, status: 500
  end

  resource_description do
    error code: 401, desc: "Unauthorized"
    error code: 404, desc: "Not Found"
  end

end
