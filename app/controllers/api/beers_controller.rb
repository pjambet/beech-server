
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
    @beers = @beers.accepted
    render json: @beers
  end

  api :POST, "/beers", "Create a beer"
  param :beer, Hash do
    param :name, String
  end
  def create
    begin
      @beer = current_user.created_beers.create(beer_params)
      NotificationMailer.new_beer(@beer).deliver
      render json: @beer
    rescue ActionController::ParameterMissing
      render json: {error: "Error"}
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name)
  end

end

