class Api::V1::GuestGamesController < ApplicationController
  skip_before_action :authorized?

  def initialize(guest_game_service: GuestGameService.new)
      @guest_game_service = guest_game_service
  end

  def find_or_create
    render json: ResponseEntity.success(data: @guest_game_service.find_or_create(params), message: -> { "Game Created!" }), status: :ok
  end

  def guess
    render json: ResponseEntity.success(data: @guest_game_service.guess(guest_game_params, params[:session_id]), message: -> { "Guess Attempt!" }), status: :ok
  end

  private
  def guest_game_params
    params.require(:guess).permit(
      :value,
    )
  end
end
