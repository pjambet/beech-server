class Admin::BadgesController < Admin::ApplicationController
  load_resource only: [:edit, :update, :destroy]

  def index
    @badges = Badge.scoped
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new params[:badge]
    if @badge.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @badge.update_attributes params[:badge]
      redirect_to admin_badges_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end
end
