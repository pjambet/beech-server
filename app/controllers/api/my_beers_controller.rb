class Api::MyBeersController < Api::ApplicationController
  include UserLoader
  load_user

  def index
    @beers = @user.beers.ordered.paginate params[:page]
    render json: @beers, each_serializer: MyBeersSerializer, root: 'beers'
  end
end


