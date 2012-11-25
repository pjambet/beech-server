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
    @users = User.where('nickname LIKE ?', "%#{params[:s]}%")
    render json: @users
  end
end
