class Admin::BadgesController < Admin::ApplicationController
  before_filter :badge_params, only: %i(create update)
  load_and_authorize_resource

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new badge_params
    if @badge.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @badge.update_attributes badge_params
      redirect_to admin_badges_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def badge_params
    params.require(:badge).permit!
  end
end
