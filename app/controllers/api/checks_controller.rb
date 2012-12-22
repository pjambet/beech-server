class Api::ChecksController < Api::ApplicationController
  include UserLoader

  load_user

  def index
    @checks = @user.checks
    render json: @checks
  end

  def create
    @check = Check.new params[:check] do |c|
      c.user_id = params[:user_id]
    end

    render json: @check if @check.save
  end

end

