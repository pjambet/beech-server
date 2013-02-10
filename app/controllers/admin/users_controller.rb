class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.scoped
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
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
      @user.update_with_password(params[:user])
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)

      @user.update_without_password(params[:user])
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
      !params[:user][:password].empty?
  end
end

