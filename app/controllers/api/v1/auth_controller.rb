class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized?

  def initialize(auth_service: AuthService.new)
    @auth_service = auth_service
  end

  def register
    render json: @auth_service.register(user_params), status: :created
  end

  def login
    render json: @auth_service.login(user_params), status: :created
  end

  def is_logged_in
    render json: @auth_service.is_logged_in(request), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
    )
  end
end
