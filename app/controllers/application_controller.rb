class ApplicationController < ActionController::API
  include GlobalErrorHandler
  include ActionController::Cookies
end
