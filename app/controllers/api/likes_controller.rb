class Api::LikesController < Api::ApplicationController
  load_and_authorize_resource :event

  def index
    @likes = @event.likes.includes(:user)
    render json: @likes
  end

  def create
    @like = current_user.like(@event)
    render json: @like
  end

  def destroy
    @like = current_user.unlike(@event)
    render json: @like
  end
end
