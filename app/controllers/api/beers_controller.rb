
class Api::BeersController < Api::ApplicationController
  resource_description do
    short 'Beer related endpoints'
    formats ['json']
    error 500, "Server crashed for some reason"
  end

  include SearchableMethods

  can_search_for :beers

  api :GET, '/beers/', 'List all beers'
  param :page, :number, desc: 'The page index'
  description 'This endpoint returns the list of beers'
  def index
    @beers = @beers.accepted.page params[:page] if @beers.any?
    render json: @beers
  end

  def show
    @beer = Beer.find(params[:id])
    render json: @beer
  end

  api :POST, "/beers", "Create a beer"
  param :beer, Hash do
    param :name, String
  end
  def create
    @beer = current_user.created_beers.create(params[:beer])
    NotificationMailer.new_beer(@beer).deliver
    render json: @beer
  end

end

