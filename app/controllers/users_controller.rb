class UsersController < ApplicationController
  def index
    @users = User.except(current_user).limit(10)
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def search
    @users = User.except(current_user).where('nickname LIKE ?', "%#{params[:s]}%")
    render json: @users, followings: current_user.following_users
  end
end
