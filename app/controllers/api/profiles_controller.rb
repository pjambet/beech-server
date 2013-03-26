class Api::ProfilesController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, "/my/profile", "Show a profile"
  api :GET, "/users/:user_id/profile", "Show a profile"
  def show
    @events = Event.for_users([@user])
    @events = @events.before(params[:before]) if params[:before].present?
    @events = @events.page params[:page]

    render json: @user, serializer: MyProfileSerializer, root: 'profile', events: @events
  end

  api :PUT, "/my/profile", "Update a profile"
  def update
    status = current_user.update_attributes(params[:user]) ? 200 : 422
    render json: current_user, status: status
  end

end

