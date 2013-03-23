
class Api::BeersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :beers

  def index
    @beers = @beers.accepted.page params[:page] if @beers.any?
    render json: @beers
  end

  def create
    @beer = current_user.created_beers.create(params[:beer])
    NotificationMailer.new_beer(@beer).deliver
    render json: @beer
  end

end

