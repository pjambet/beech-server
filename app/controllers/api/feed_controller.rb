class Api::FeedController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, '/my/feed/'
  param :users, desc: 'If set to to me'
  description "method description"
  formats ['json']
  def index
    @events = filter_events.includes(:user, :eventable, {comments: :user}, {likes: :user}).page params[:page]
    render json: @events, liked_events: current_user.liked_events
  end

  private

  def filter_events
    events = select_events_for_users
    events = select_events_for_period(events)
    events
  end

  def select_events_for_users(events=Event.scoped)
    if params[:users] == 'me'
      events.for_users([@user])
    else
      events.for_users(@user.self_and_following_users)
    end
  end

  def select_events_for_period(events=Event.scoped)
    events = events.after(params[:after]) if params[:after].present?
    events = events.before(params[:before]) if params[:before].present?
    events
  end

end

