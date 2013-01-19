class Api::MyBadgesController < Api::ApplicationController
  include UserLoader
  load_user

  def index
    @badges = @user.badges.ordered
    render json: @badges
  end

end

