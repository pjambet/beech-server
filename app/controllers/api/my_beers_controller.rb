class Api::MyBeersController < Api::ApplicationController
  include UserLoader
  load_user

  api :GET, "/my/beers", "List my beers"
  api :GET, "/users/:user_id/beers", "List my beers"
  def index
    @beers = @user.beers.ordered
    render json: @beers, each_serializer: MyBeersSerializer, root: 'beers'
  end
end


