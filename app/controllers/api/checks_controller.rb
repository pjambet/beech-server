class Api::ChecksController < Api::ApplicationController

  api :POST, "/checks", "Create a check"
  param :check, Hash do
    param :beer_id, :number
    param :user_id, :number
  end
  def create
    @check = current_user.checks.create params[:check]
    BadgeChecker.new(current_user).check_if_user_earned_new_badges
    render json: @check
  end

end

