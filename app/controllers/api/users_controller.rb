class Api::UsersController < Api::ApplicationController
  include SearchableMethods

  can_search_for :users

  api :GET, "/users", "List users"
  def index
    @users = @users.exclude(current_user).ordered.limit(10)
    @users = @users.after(params[:after]) if params[:after].present?
    render json: @users
  end
end

