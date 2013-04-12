class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource :event

  def index
    @comments = @event.comments
    render json: @comments
  end

  def create
    @comment = current_user.comment(@event, params[:comment])
    render json: @comment
  end

  def destroy
    @comment = Comment.find(params['id'])
    current_user.comments.delete @comment
    render json: @comment
  end
end
