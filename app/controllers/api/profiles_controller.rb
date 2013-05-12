class Api::ProfilesController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, "/my/profile", "Show a profile"
  api :GET, "/users/:user_id/profile", "Show a profile"
  def show
    @events = Event.for_users([@user]).includes(:user, :eventable, {comments: :user}, {likes: :user})
    @events = @events.before(params[:before]) if params[:before].present?
    @events = @events.page params[:page]

    render json: @user, serializer: MyProfileSerializer, root: 'profile', events: @events
  end

  api :PUT, "/my/profile", "Update a profile"
  def update
    begin
      status = current_user.update_attributes(profile_params) ? 200 : 422
      render json: current_user, status: status
    rescue ActionController::ParameterMissing
      render json: {error: 'Bad request'}, code: 400
    end
  end

  def profile_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :remember_me, :nickname, :login, :avatar)
  end

end

