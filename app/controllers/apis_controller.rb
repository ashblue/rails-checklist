class ApisController < ApplicationController
  before_filter :verify_user

  # @TODO Testing only, remove before production
  # Will require that we place the token in the body and push it for requests
  skip_before_action :verify_authenticity_token

  private
  def verify_user
    unless user_signed_in?
      render :json => {:errors => 'Not authenticated'}, :status => 401
    end
  end

  def parse_request
    logger.debug request.body
    @json = JSON.parse(request.body.read.html_safe)
  end
end
