class Api::MyBeersController < Api::ApplicationController

  def index
    @beers = current_user.beers.ordered.paginate params[:page]
    render json: @beers, each_serializer: MyBeersSerializer
  end
end


