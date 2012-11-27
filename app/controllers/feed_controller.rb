class FeedController < ApplicationController

  def index
    @events = Event.for_users(current_user.following_users + [ current_user ])
    @events = Event.after(params[:after]) if params[:after].present?

    render json: @events, each_serializer: FeedSerializer
  end

end

