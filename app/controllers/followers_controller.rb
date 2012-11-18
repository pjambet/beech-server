class FollowersController < ApplicationController
  def index
    current_user.follower_users
  end
end

