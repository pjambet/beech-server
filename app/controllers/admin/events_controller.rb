class Admin::EventsController < Admin::ApplicationController
  load_and_authorize_resource

  def index
    @events = @events.page(params[:page]).order('created_at DESC')
  end

end

