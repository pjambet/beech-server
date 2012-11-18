class FollowingsController < ApplicationController
  def create
    follower = User.new params[:followee]
    unless current_user.following_users.include? follower
      current_user.following_users << follower
    end
  end
end
