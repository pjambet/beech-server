class FollowingsController < ApplicationController

  def index
    render json: current_user.following_users, root: "users"
  end

  def create
    follower = User.find params[:user_id]
    unless current_user.following_users.include? follower
      current_user.following_users << follower
    end
    render json: follower
  end

  def destroy
    follower = User.find params[:user_id]
    if current_user.following_users.include? follower
      current_user.following_users.delete follower
    end
    render json: follower

  end
end
