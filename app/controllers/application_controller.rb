class ApplicationController < ActionController::Base

  def after_sign_in_path_for(user)
    user_path user
  end

  def after_sign_up_path_for(user)
    user_path user
  end

  if Rails.env.development?
    def current_user
      User.find(1)
    end
  end
end
