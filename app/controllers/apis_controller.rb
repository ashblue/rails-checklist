class ApisController < ApplicationController
  before_filter :authenticate_user_from_token!, :parse_request

  private

  # Prevent Rails meta data and params from leaking in by only passing the request body
  def parse_request
    unless request.body.read.empty?
      @json = JSON.parse(request.body.read.html_safe)
    end
  end
end
