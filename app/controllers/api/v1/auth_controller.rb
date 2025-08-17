class Api::V1::AuthController < ApplicationController
  def initialize(auth_service: AuthService.new)
    @auth_service = auth_service
  end

  def register
    render json: ResponseEntity.success(data: @auth_service.register(user_params), message: -> { "Registration Succesful" }), status: :created
  end

  def login
        render json: ResponseEntity.success(data: @auth_service.login(user_params), message: -> { "User Authenticated!" }), status: :ok
  end

  def is_logged_in
        puts "+++++++++++++++++++++++++++++++++++++++"
        puts params
        puts "+++++++++++++++++++++++++++++++++++++++"
        render json: ResponseEntity.success(data: @auth_service.is_logged_in(params), message: -> { "User is Signed in" }), status: :ok
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
