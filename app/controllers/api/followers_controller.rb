class Api::FollowersController < Api::ApplicationController
  def index
    render json: current_user.follower_users, root: "users"
  end
end

