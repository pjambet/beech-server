class Api::FollowingsController < Api::ApplicationController
  include BeechServer::Controllers::Concerns
  load_user

  def index
    render json: @user.following_users, root: "users"
  end

  def create
    followee = User.find params[:user_id]
    unless current_user.following_users.include? followee
      current_user.following_users << followee
    end
    render json: followee
  end

  def destroy
    followee = User.find params[:user_id]
    if current_user.following_users.include? followee
      current_user.following_users.destroy followee
    end
    render json: followee

  end

end
