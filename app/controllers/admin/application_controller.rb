class Admin::ApplicationController < ApplicationController
  before_filter :authenticate_user!, :authenticate_admin!

  layout 'admin'

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.admin?
  end

end

