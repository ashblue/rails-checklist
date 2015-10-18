class EntriesController < ApisController
  def index
    render json: Entry.all
  end
end
