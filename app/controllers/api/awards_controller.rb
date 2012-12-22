class Api::AwardsController < Api::ApplicationController
  include UserLoader

  load_user

  def index
    @awards = @user.awards
    render json: @awards
  end
end

