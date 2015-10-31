class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected
  # https://github.com/lynndylanhurley/devise_token_auth
  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      email = options[:email].presence
      user = email && User.find_by_email(email)

      if user
        if Devise.secure_compare(user.authentication_token, token)
          sign_in user, store: false
        else
          render json: 'Invalid authorization.'
        end
      else
        render json: 'No authorization provided.'
      end
    end
  end
end
