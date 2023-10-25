class GuardController < ApplicationController
  include JWTSessions::RailsAuthorization
  before_action :authorize_access_request!
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

end
