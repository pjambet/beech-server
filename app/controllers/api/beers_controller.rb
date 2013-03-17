
class Api::BeersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :beers

  api :GET, '/beers/'
  param :page, desc: 'The page index'
  description "method description"
  formats ['json']
  def index
    @beers = @beers.accepted.paginate params[:page] if @beers.any?
    render json: @beers
  end

  api :POST, '/beers/'
  param :page, desc: 'The page index'
  description "method description"
  formats ['json']
  def create
    @beer = Beer.new(params[:beer]).tap {|beer| beer.added_by = current_user}
    @beer.save
    render json: @beer
  end

end

