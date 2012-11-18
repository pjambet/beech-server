class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def search
    @users = User.where('nickname LIKE ?', "%#{params[:s]}%")
    render json: @users
  end
end
