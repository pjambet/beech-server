
class Api::BeersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :beers

  def index
    @beers = @beers.paginate params[:page] if @beers.any?
    render json: @beers
  end

  def create
    @beer = Beer.new(params[:beer]).tap {|beer| beer.added_by = current_user}
    @beer.save
    render json: @beer
  end

end

