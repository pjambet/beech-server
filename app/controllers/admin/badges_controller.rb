class Admin::BadgesController < Admin::ApplicationController

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
    @badge = Badge.find(params[:id])
  end

  def update
    @badge = Badge.find(params[:id])
    if @badge.update_attributes params[:badge]
      redirect_to admin_badges_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy
    redirect_to admin_badges_path
  end
end
