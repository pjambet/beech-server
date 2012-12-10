class Api::FollowersController < Api::ApplicationController
  include BeechServer::Controllers::Concerns
  load_user

  def index
    render json: @user.follower_users, root: "users"
  end
end

