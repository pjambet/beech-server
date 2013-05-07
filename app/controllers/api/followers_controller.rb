class Api::FollowersController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, "/my/followers", "List followers"
  api :GET, "/users/:user_id/followers", "List followers"
  def index
    render json: @user.follower_users, root: "users"
  end
end

