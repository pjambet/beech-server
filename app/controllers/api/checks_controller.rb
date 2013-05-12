class Api::ChecksController < Api::ApplicationController

  api :POST, "/checks", "Create a check"
  param :check, Hash do
    param :beer_id, :number
    param :user_id, :number
  end
  def create
    @check = current_user.checks.create check_params
    BadgeChecker.new(current_user).check_if_user_earned_new_badges
    render json: @check
  end

  private

  def check_params
    params.require(:check).permit(:user_id, :beer_id, :user, :beer)
  end

end

