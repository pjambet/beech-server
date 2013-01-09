class Users::SessionsController < Devise::SessionsController

  protect_from_forgery except: :create

  respond_to :json

  def create
    super
  end
end

