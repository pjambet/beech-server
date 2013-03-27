class ApplicationController < ActionController::Base

  respond_to :html, :json

  def after_sign_in_path_for(user)
    user_path user
  end

  def after_sign_up_path_for(user)
    user_path user
  end

  rescue_from Exception, with: :render_error

  private

  def render_error(exception)
    if Rails.application.config.consider_all_requests_local
      raise exception
    else
      respond_to do |format|
        format.html do
          status = status_for_exception(exception)
          render(template: "errors/error_#{status}",
                 layout: 'layouts/errors',
                 status: status)
        end
        format.all { render nothing: true, status: status }
      end
    end
  end

  def status_for_exception(exception)
    case exception
    when CanCan::AccessDenied
      401
    when ActionController::RoutingError,
      ActionController::UnknownController,
      ::AbstractController::ActionNotFound,
      ActiveRecord::RecordNotFound
      404
    else
      Raven.capture_exception(exception)
      500
    end
  end
end
