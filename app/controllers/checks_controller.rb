class ChecksController < ApplicationController

  before_filter :load_user

  def index
    @checks = @user.checks
    render json: @checks
  end

  def create
    @check = Check.new params[:check]
    @check.save
    render json: @check
  end

  protected

  def load_user
    @user = User.find params[:user_id]
  end
end
