class Api::AwardsController < Api::ApplicationController
  include BeechServer::Controllers::Concerns

  load_user

  def index
    @awards = @user.awards
    render json: @awards
  end
end

