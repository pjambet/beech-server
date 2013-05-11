class Api::ChecksController < Api::ApplicationController

  api :POST, "/checks", "Create a check"
  param :check, Hash do
    param :beer_id, :number
    param :user_id, :number
  end
  def create
    @check = current_user.checks.create params[:check]

    render json: @check
  end

end

