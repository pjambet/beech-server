class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource :event

  def index
    @comments = @event.comments.includes(:user)
    if params[:before]
      @comments = @comments.before(params[:before])
    else
      @comments = @comments.order('created_at DESC').limit(5)
    end
    render json: @comments, meta: { total: @event.comments.count }
  end

  def create
    @comment = current_user.comment(@event, comment_params)
    render json: @comment
  end

  def destroy
    @comment = Comment.find(params['id'])
    current_user.comments.delete @comment
    render json: @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :event)
  end
end
