class Users::SessionsController < Devise::SessionsController

  protect_from_forgery except: :create

  def create
    super
  end
end

