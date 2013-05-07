class Api::LikesController < Api::ApplicationController
  load_and_authorize_resource :event

  def index
    @likes = @event.likes.includes(:user)
    if params[:before]
      @likes = @likes.before(params[:before])
    else
      @likes = @likes.order('created_at DESC').limit(20)
    end
    render json: @likes, meta: { total: @event.likes.count }
  end

  def create
    @like = current_user.like(@event)
    render json: @event
  end

  def destroy
    @like = current_user.unlike(@event)
    render json: @event
  end
end
