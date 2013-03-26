
class Api::BeersController < Api::ApplicationController
  resource_description do
    short 'Beer related endpoints'
    formats ['json']
    error 404, "Missing"
    error 500, "Server crashed for some <%= reason %>"
  end

  include SearchableMethods

  can_search_for :beers

  api :GET, '/beers/', 'List all beers'
  param :page, :number, desc: 'The page index'
  description 'This endpoint returns the list of beers'
  def index
    @beers = @beers.accepted.paginate params[:page] if @beers.any?
    render json: @beers
  end

  def create
    @beer = Beer.new(params[:beer]).tap {|beer| beer.added_by = current_user}
    @beer.save
    render json: @beer
  end

end

