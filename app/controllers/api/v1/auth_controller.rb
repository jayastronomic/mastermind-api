class Api::V1::AuthController < ApplicationController
  def initialize(auth_service: AuthService.new)
    @auth_service = auth_service
  end

  def register
    token, user = @auth_service.register(user_params)

    # Set HTTP-only cookie
    cookies[:jwt_token] = {
      value: token,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :none,
      expires: 24.hours.from_now,
    }

    render json: ResponseEntity.success(data: user, message: -> { "Registration Successful" }), status: :created
  end

  def login
    token, user = @auth_service.login(user_params)

    # Set HTTP-only cookie
    cookies[:jwt_token] = {
      value: token,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax,
      expires: 24.hours.from_now,
    }

    render json: ResponseEntity.success(data: user, message: -> { "User Authenticated!" }), status: :ok
  end

  def is_logged_in
    Rails.logger.info cookies
    render json: ResponseEntity.success(data: @auth_service.is_logged_in(params), message: -> { "User is Signed in" }), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :password,
    )
  end
end
