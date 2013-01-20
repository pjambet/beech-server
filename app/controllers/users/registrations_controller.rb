class Users::RegistrationsController < Devise::RegistrationsController

  protect_from_forgery except: :create

  respond_to :json

  def new
    super
  end

  def create
    params[:user][:password_confirmation] = params[:user][:password] if params[:user].present?
    super
  end
end

