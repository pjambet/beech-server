class BeersController < ApplicationController
  include BeechServer::Searchable::Controllers

  can_search_for :beers

  def index
    render json: @beers
  end

end

