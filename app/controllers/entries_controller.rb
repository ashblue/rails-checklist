class EntriesController < ApisController
  before_filter :find_checklist, only: [:index, :create]
  before_filter :find_entry, only: [:show, :update, :destroy]

  def index
    render json: @checklist.entries
  end

  def create
    @entry = Entry.new(params)
    if @entry.save
      @checklist.entries << @entry
      render json: @entry
    else
      render nothing: true, status: :bad_request
    end
  end

  def show
    render json: @entry
  end

  def update
    @entry.update_attributes(params)
    if @entry.save
      render json: @entry
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    if Entry.destroy(@entry.id)
      render nothing: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private
  def find_entry
    @entry = Entry.where(:checklist_id => params[:checklist_id], :id => params[:entry_id]).first
    if !@entry.present?
      render nothing: true, status: :not_found
    elsif @entry.checklist.user.id != current_user.id
      render :json => { :errors => 'Incorrect permission' }, :status => :bad_request
    end
  end

  def find_checklist
    @checklist = Checklist.find_by_id(params[:checklist_id])
    if !@checklist.present?
      render nothing: true, status: :not_found
    elsif @checklist.user_id != current_user.id
      render :json => { :errors => 'Incorrect permission' }, :status => :bad_request
    end
  end
end
