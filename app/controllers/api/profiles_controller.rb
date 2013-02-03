class Api::ProfilesController < Api::ApplicationController
  include UserLoader
  load_user

  def show
    @events = Event.for_users([@user])
    @events = @events.before(params[:before]) if params[:before].present?
    @events = @events.paginate params[:page]

    render json: @user, serializer: MyProfileSerializer, root: 'profile', events: @events
  end

  def update
    status = current_user.update_attributes(params[:user]) ? 200 : 422
    render json: current_user, status: status
  end

end

