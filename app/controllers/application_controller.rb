class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected
  # Can't use built-in authentication API for Devise (deprecated). Security sucks on the code below
  # and you should consider upgrading to a more secure solution.
  # For a token solution with good security I recommend
  # https://github.com/lynndylanhurley/devise_token_auth
  def authenticate_user_from_token!
    email = params[:email].presence
    user = email && User.find_by_email(email)

    if user
      if Devise.secure_compare(user.authentication_token, params[:token])
        sign_in user, store: false
      else
        render json: 'Invalid authorization.'
      end
    else
      render json: 'No authorization provided.'
    end
  end
end
