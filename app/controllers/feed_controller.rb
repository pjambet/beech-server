class FeedController < ApplicationController

  def index
    @checks = Check.for_users(current_user.following_users + [ current_user ])
    @checks = @checks.after(params[:after]) if params[:after].present?

    render json: @checks, each_serializer: CheckSerializer
  end

end

