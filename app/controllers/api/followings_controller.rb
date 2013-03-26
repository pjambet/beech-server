class Api::FollowingsController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, "/my/followings", "List followings"
  api :GET, "/users/:user_id/followings", "List followings"
  def index
    render json: @user.following_users, root: "users"
  end

  api :POST, "/my/followings", "Create a following"
  param :user_id, :undef
  def create
    handle_action
  end

  api :DELETE, "/my/followings", "Destroy a following"
  param :id, :undef
  param :user_id, :number
  def destroy
    handle_action
  end

  private

  def handle_action
    followee = User.find params[:user_id]
    if current_user.following_users.include? followee
      current_user.unfollow(followee)
    else
      current_user.follow(followee)
    end
    render json: followee
  end

end
