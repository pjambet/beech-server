class Api::ProfilesController < Api::ApplicationController

  def index
  end

  def show
    @user = User.find params[:id]
    render json: @user, serializer: MyUserSerializer, root: 'profile'
  end

  def update
    status = current_user.update_attributes(params[:user]) ? 200 : 422
    render json: current_user, status: status
  end

end

