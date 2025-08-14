class Api::V1::AuthController < ApplicationController
  def initialize(auth_service: AuthService.new)
    @auth_service = auth_service
  end

  def register
    render json: @auth_service.register(user_params), status: :created
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email
    )
  end
end
