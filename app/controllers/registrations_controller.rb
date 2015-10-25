class RegistrationsController < Devise::RegistrationsController
  clear_respond_to # Remove HTML support
  respond_to :json
end