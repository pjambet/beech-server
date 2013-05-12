class Admin::UsersController < Admin::ApplicationController
  before_filter :user_params, only: %i(create update)
  load_and_authorize_resource

  def index
    @users = User.order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(user_params)
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      user_params.delete(:current_password)

      @user.update_without_password(user_params)
    end

    if successfully_updated
      redirect_to admin_users_path
    else
      render 'edit', status: 422
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      !user_params[:password].empty?
  end

  def user_params
    params.require(:user).permit!
  end
end

