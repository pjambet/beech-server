class Admin::EventsController < Admin::ApplicationController
  load_and_authorize_resource :event

  def index
    @events = @events.paginate(params[:page]).order('created_at DESC')
  end

end

