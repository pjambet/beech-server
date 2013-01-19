class Api::ProfilesController < Api::ApplicationController

  def show
    @user = params[:id].present? ? User.find(params[:id]) : current_user
    render json: @user, serializer: MyProfileSerializer, root: 'profile'
  end

  def update
    status = current_user.update_attributes(params[:user]) ? 200 : 422
    render json: current_user, status: status
  end

end

