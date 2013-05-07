class Api::MyBadgesController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, "/my/badges", "List my badges"
  api :GET, "/users/:user_id/badges", "List my badges"
  def index
    @badges = @user.badges.ordered
    render json: @badges, root: 'badges'
  end

end

