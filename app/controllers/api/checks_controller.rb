class Api::ChecksController < Api::ApplicationController
  include UserLoader

  load_user

  def index
    @checks = @user.checks
    render json: @checks
  end

  def create
    @check = current_user.checks.create params[:check]

    render json: @check if @check.save
  end

end

