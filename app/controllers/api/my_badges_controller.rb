class Api::MyBadgesController < Api::ApplicationController

  def index
    @badges = current_user.badges
    render json: @badges
  end

end

