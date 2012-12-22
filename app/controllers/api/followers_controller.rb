class Api::FollowersController < Api::ApplicationController
  include UserLoader
  load_user

  def index
    render json: @user.follower_users, root: "users"
  end
end

