class ChecksController < ApplicationController

  before_filter :load_user

  def index
    @checks = @user.checks
    render json: @checks
  end

  def create
    @check = Check.new params[:check] do |c|
      c.user_id = params[:user_id]
    end

    if @check.save
      render json: @check
    end
  end

  protected

  def load_user
    @user = User.find params[:user_id]
  end
end
