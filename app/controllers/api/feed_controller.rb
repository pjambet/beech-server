class Api::FeedController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, '/my/feed/'
  param :users, desc: 'If set to to me'
  description "method description"
  formats ['json']
  def index
    if params[:users] == 'me'
      @events = Event.for_users([@user])
    else
      @events = Event.for_users(@user.self_and_following_users)
    end
    @events = @events.after(params[:after]) if params[:after].present?
    @events = @events.before(params[:before]) if params[:before].present?
    @events = @events.paginate params[:page]

    render json: @events
  end

end

