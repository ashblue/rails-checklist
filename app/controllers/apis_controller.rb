class ApisController < ApplicationController
  before_filter :authenticate_user_from_token!, :set_default_response_format, :parse_request

  private

  def set_default_response_format
    request.format = :json
  end

  # Prevent Rails meta data and params from leaking in by only passing the request body
  def parse_request
    unless request.body.read.empty?
      @json = JSON.parse(request.body.read.html_safe)
    end
  end
end
