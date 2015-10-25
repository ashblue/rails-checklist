class ApisController < ApplicationController
  before_filter :verify_user

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
