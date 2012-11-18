class FeedController < ApplicationController

  def index
    @checks = Check.for_users(current_user.following_users)
    render json: @checks, each_serializer: CheckSerializer
  end

end

