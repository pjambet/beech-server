class Admin::BeersController < Admin::ApplicationController

  def index
    @beers = Beer.accepted
    @suggestions = Beer.suggestions
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
    @beer = Beer.find(params[:id])
  end

  def update
    @beer = Beer.find(params[:id])
    if @beer.update_attributes params[:beer]
      redirect_to admin_beers_path
    else
      render :edit
    end
  end

  def accept
    @beer = Beer.find(params[:id])
    @beer.accepted = true
    @beer.save
    redirect_to admin_beers_path
  end

  def reject
    @beer = Beer.find(params[:id])
    @beer.accepted = false
    @beer.save
    redirect_to admin_beers_path
  end

  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy
    redirect_to admin_beers_path
  end
end
