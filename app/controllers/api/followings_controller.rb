class Api::FollowingsController < Api::ApplicationController

  def index
    render json: current_user.following_users, root: "users"
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
