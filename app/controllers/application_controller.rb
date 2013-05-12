class ApplicationController < ActionController::Base

  before_filter :set_locale, :set_user_agent

  respond_to :html, :json

  def after_sign_in_path_for(user)
    user_path user
  end

  def after_sign_up_path_for(user)
    user_path user
  end

  def set_user_agent
    # TODO : detect android and other devices
    if request.env['HTTP_USER_AGENT'].match(/(iPhone|iPad|iPod)/)
      @user_agent = :ios
    else
      @user_agent = :other
    end
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
  end

  rescue_from Exception, with: :render_error

  private

  def render_error(exception)
    if Rails.application.config.consider_all_requests_local
      raise exception
    else
      respond_to do |format|
        status = status_for_exception(exception)
        format.html do
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

  def extract_locale_from_accept_language_header
    preferred_language = request.env['HTTP_ACCEPT_LANGUAGE'] || ''
    preferred_language = preferred_language.scan(/^[a-z]{2}/).first

    if available_locales.include?(preferred_language)
      preferred_language
    else
      :en
    end
  end

  def available_locales
    I18n.available_locales + I18n.available_locales.map(&:to_s)
  end
end
