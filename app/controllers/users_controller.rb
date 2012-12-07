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
    params[:s] ||= ""
    @users = User.except(current_user).where('lower(nickname) ILIKE ?', "%#{params[:s].downcase}%")
    render json: @users, followings: current_user.following_users
  end
end
