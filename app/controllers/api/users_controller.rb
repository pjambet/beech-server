class Api::UsersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :users

  def index
    @users = @users.exclude(current_user).limit(10)
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

end

