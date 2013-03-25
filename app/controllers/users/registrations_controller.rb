class Users::RegistrationsController < Devise::RegistrationsController

  protect_from_forgery except: :create

  def new
    super
  end

  def create
    params[:user][:password_confirmation] = params[:user][:password] if params[:user].present?
    super
    NotificationMailer.new_user(resource).deliver if resource.persisted?
  end
end

