class Api::ApplicationController < ApplicationController
  before_filter :set_locale, :skip_trackable, :authenticate_user!

  def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
  end

  rescue_from Exception, with: (lambda do |exception|
    if Rails.application.config.consider_all_requests_local
      raise exception
    else
      render_error
      Raven.capture_exception(exception)
    end
  end)

  def render_error
    render json: {error: 'An error occured'}
  end

  resource_description do
    error code: 401, desc: "Unauthorized"
    error code: 404, desc: "Not Found"
  end

  private

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
