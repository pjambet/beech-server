class BeersController < ApplicationController
  def index
    if params[:s].present?
      @beers = Beer.where('lower(name) ILIKE ?', "%#{params[:s].downcase}%")
    else
      @beers = Beer.all
    end
    render json: @beers
  end

end

