class Api::ApplicationController < ApplicationController
  before_filter :skip_trackable, :authenticate_user!

  def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

  rescue_from Exception, with: (lambda do |exception|
    render_error
    unless Rails.application.config.consider_all_requests_local
      Raven.capture_exception(exception)
    end
  end)

  def render_error
    render json: {error: 'An error occured'}
  end

end
