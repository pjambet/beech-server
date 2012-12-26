class Api::UsersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :users

  def index
    @users = @users.except(current_user).limit(10)
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    status = if current_user.update_attributes params[:user]
               :success
             else
               :unprocessable_entity
             end

    render json: @user, status: status
  end
end

