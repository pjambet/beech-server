class Api::FeedController < Api::ApplicationController
  include UserLoader
  load_user

  def index
    if params[:users] == 'me'
      @events = Event.for_users([@user])
    else
      @events = Event.for_users(@user.self_and_following_users)
    end
    @events = @events.after(params[:after]) if params[:after].present?
    @events = @events.before(params[:before]) if params[:before].present?
    @events = @events.page params[:page]

    render json: @events
  end

end

