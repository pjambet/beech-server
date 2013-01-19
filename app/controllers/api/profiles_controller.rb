class Api::ProfilesController < Api::ApplicationController
  include UserLoader
  load_user

  def show
    render json: @user, serializer: MyProfileSerializer, root: 'profile'
  end

  def update
    status = current_user.update_attributes(params[:user]) ? 200 : 422
    render json: current_user, status: status
  end

end

