class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @beers = @user.beers.includes(:beer_color)
  end

end
