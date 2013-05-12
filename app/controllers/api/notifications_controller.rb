class Api::NotificationsController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, '/my/notifications/'
  param :users, desc: ''
  description "method description"
  formats ['json']
  def index
    @notifications = @user.notifications
    render json: @notifications
  end
end

