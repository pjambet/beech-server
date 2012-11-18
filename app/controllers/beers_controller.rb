class BeersController < ApplicationController
  def index
    @beers = Beer.all
    render json: @beers
  end

end

