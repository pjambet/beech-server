class ApplicationController < ActionController::Base

  def after_sign_in_path_for(user)
    user_path user
  end

  def after_sign_up_path_for(user)
    user_path user
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception => e, with: (lambda do |exception|
      render_error 500, exception
      notify_honeybadger(e)
    end)
    rescue_from CanCan::AccessDenied,
              with: lambda { |exception| render_error 401, exception }

    rescue_from ActionController::RoutingError,
                ActionController::UnknownController,
                ::AbstractController::ActionNotFound,
                ActiveRecord::RecordNotFound,
                with: lambda { |exception| render_error 404, exception }
  end

  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/errors', status: status }
      format.all { render nothing: true, status: status }
    end
  end


end
