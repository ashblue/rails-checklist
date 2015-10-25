class ApisController < ApplicationController
  before_filter :authenticate_user_from_token!

  private
  def parse_request
    @json = JSON.parse(request.body.read.html_safe)
  end
end
