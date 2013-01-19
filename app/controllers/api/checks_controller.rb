class Api::ChecksController < Api::ApplicationController

  def create
    @check = current_user.checks.create params[:check]

    render json: @check if @check.save
  end

end

