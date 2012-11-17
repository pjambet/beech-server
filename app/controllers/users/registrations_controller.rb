class Users::RegistrationsController < Devise::RegistrationsController

  protect_from_forgery except: :create

  def new
    super
  end

  def create
    params[:password_confirmation] = params[:password]
    super
  end
end

