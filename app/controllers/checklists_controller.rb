class ChecklistsController < ApisController
  before_filter :find_checklist, only: [:show, :update, :destroy]

  def index
    render json: Checklist.where(user_id: current_user.id).to_json(:include => :entries)
  end

  def create
    @checklist = Checklist.new(params)
    @checklist.user = current_user
    if @checklist.save
      render json: @checklist.to_json(:include => :entries)
    else
      render nothing: true, status: :bad_request
    end
  end

  def show
    render json: @checklist.to_json(:include => :entries)
  end

  def update
    @checklist.update_attributes(params)
    if @checklist.save
      render json: @checklist.to_json(:include => :entries)
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    Entry.where(:checklist_id => :checklist_id).each { |entry|
      Entry.destroy(entry.id)
    }

    if Checklist.destroy(@checklist.id)
      render nothing: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private
  def find_checklist
    @checklist = Checklist.find_by_id(params[:checklist_id])
    if !@checklist.present?
      render nothing: true, status: :not_found
    elsif @checklist.user_id != current_user.id
      render :json => { :errors => 'Incorrect permission' }, :status => :bad_request
    end
  end

end
