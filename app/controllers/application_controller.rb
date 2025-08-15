class ApplicationController < ActionController::API
  include GlobalErrorHandler
  include JwtService

  before_action :authorized?

  private

  def authorized?
    decode_token(request)
  end
end
