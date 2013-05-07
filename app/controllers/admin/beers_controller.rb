class Admin::BeersController < Admin::ApplicationController
  load_and_authorize_resource

  def index
    @beers = Beer.accepted
    @suggested = Beer.suggested
    @rejected = Beer.rejected
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(params[:beer]).tap do |beer|
      beer.accepted = true
      beer.added_by = current_user
    end
    if @beer.save
      redirect_to admin_beers_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @beer.update_attributes params[:beer]
      redirect_to admin_beers_path
    else
      render :edit
    end
  end

  def accept
    @beer.accepted = true
    @beer.save
    NotificationMailer.accepted_beer(@beer).deliver
    redirect_to admin_beers_path
  end

  def reject
    @beer.accepted = false
    @beer.save
    redirect_to admin_beers_path
  end

  def destroy
    @beer.destroy
    redirect_to admin_beers_path
  end

end
