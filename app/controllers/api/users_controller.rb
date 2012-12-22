class Api::UsersController < Api::ApplicationController
  def index
    @users = User.except(current_user).limit(10)
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def search
    @users = User.except(current_user)
    render json: @users, followings: current_user.following_users
  end
end
