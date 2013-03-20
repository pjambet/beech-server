
class Api::BeersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :beers

  def index
    @beers = @beers.accepted.paginate params[:page] if @beers.any?
    render json: @beers
  end

  def create
    @beer = current_user.created_beers.create(params[:beer])
    render json: @beer
  end

end

