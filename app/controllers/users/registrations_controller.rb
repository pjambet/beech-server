class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery except: :create

  def new
    super
  end

  def create
    params[:user][:password_confirmation] = params[:user][:password] if params[:user].present?
    super
    NotificationMailer.new_user(resource).deliver if resource.persisted?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:nickname, :email, :password, :password_confirmation)
    end
  end
end

