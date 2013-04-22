class Api::JournalEntriesController < Api::ApplicationController

  api :GET, '/journal_entries/'
  description "Return list of journal entries"
  formats ['json']
  def index
    @entries = JournalEntry.includes(:loggable)
    if last_id = params[:last_id]
      @entries = @entries.after(last_id)
    end
    render json: @entries
  end

end

