
class Api::BeersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :beers

  def index
    @beers = @beers.paginate if @beers.any?
    render json: @beers
  end

end
