class Api::FeedController < Api::ApplicationController
  include UserLoader
  load_user

  def index
    @events = Event.for_users(@user.self_and_following_users)
    @events = @events.after(params[:after]) if params[:after].present?
    @events = @events.before(params[:before]) if params[:before].present?
    @events = @events.paginate params[:page]

    render json: @events
  end

end

