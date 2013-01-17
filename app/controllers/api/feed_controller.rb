class Api::FeedController < Api::ApplicationController

  def index
    @events = Event.for_users(current_user.self_and_following_users)
    @events = @events.after(params[:after]) if params[:after].present?
    # TEMPORARY
    # @events = @events.paginate params[:page]

    render json: @events
  end

end

