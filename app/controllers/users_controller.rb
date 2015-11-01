class UsersController < ApisController
  before_filter :find_user

  def show
    render :json => {
               :user => {
                   :email => @user.email,
                   :id => @user.id
               }
           }
  end

  private
  def find_user
    @user = User.find_by_id(params[:user_id])
    unless @user.present?
      render nothing: true, status: :not_found
    end
  end
end
