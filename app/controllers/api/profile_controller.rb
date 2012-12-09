class Api::ProfileController < Api::ApplicationController

  def index
    @user = current_user
    render json: @user, serializer: MyUserSerializer, root: "my_profile"
  end

  def show
    @user = User.find params[:id]
    render json: @user, serializer: MyUserSerializer, root: "my_profile"
  end
end

