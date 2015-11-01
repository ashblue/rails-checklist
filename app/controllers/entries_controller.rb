class EntriesController < ApisController
  before_filter :find_entry, only: [:show, :update, :destroy]

  def index
    render :json => {
               entries: Entry.where(user_id: current_user.id)
           }
  end

  def create
    logger.debug 'BEGIN CREATE'
    logger.debug @json['entry']
    @entry = Entry.create(@json['entry'])
    logger.debug 'ENTRY CREATED WITHOUT ERROR'
    @entry.user = current_user

    if @entry.checklist.present? && @entry.checklist.user == @entry.user
      if @entry.save
        @entry.checklist.entries << @entry
        render :json => { entry: @entry }
      else
        render nothing: true, status: :bad_request
      end
    else
      render nothing: true, status: :bad_request
    end
  end

  def show
    render :json => { entry: @entry }
  end

  def update
    @entry.update_attributes(@json['entry'])
    if @entry.save
      render :json => { entry: @entry }
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
      if Entry.destroy(@entry.id)
        render :json => {}
      else
        render nothing: true, status: :bad_request
      end
  end

  private
  def find_entry
    @entry = Entry.find_by_id(params[:entry_id])
    if !@entry.present?
      render nothing: true, status: :not_found
    elsif @entry.user != current_user
      render :json => { :errors => 'Incorrect permission' }, :status => :bad_request
    end
  end
end
