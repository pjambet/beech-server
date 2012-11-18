class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(user)
    user_path user
  end

  def after_sign_up_path_for(user)
    user_path user
  end

  def current_user
    User.first
  end

end
