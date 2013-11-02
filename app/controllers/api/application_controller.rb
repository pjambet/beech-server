class Api::ApplicationController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :skip_trackable, :authenticate_user!

  def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

  rescue_from Exception, with: (lambda do |exception|
    if Rails.application.config.consider_all_requests_local
      raise exception
    else
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

  private

  def authenticate_user_from_token!
    auth_token = request.env['HTTP_AUTHORIZATION']
    if auth_token
      user_email, user_token = auth_token.split(':')
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, user_token)
        sign_in user, store: false
      end
    end
  end

end
