class Api::FollowingsController < Api::ApplicationController
  include UserLoader
  load_user

  def index
    render json: @user.following_users, root: "users"
  end

  def create
    handle_action
  end

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
