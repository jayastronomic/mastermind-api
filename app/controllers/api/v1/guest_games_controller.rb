class Api::V1::GuestGamesController < ApplicationController
  # skip_before_action :authorized?

  def initialize(guest_game_service: GuestGameService.new)
    @guest_game_service = guest_game_service
  end

  def create
    render json: ResponseEntity.success(data: @guest_game_service.create, message: -> { "Game Created!" }), status: :created
  end

  def find
    render json: ResponseEntity.success(data: @guest_game_service.find(params), message: -> { "Game Found!" }), status: :ok
  end

  def guess
    render json: ResponseEntity.success(data: @guest_game_service.guess(guest_game_params, params[:session_id]), message: -> { "Guess Attempt!" }), status: :created
  end

  def delete
    render json: ResponseEntity.success(data: @guest_game_service.delete(params), message: -> { "Game Ended!" }), status: :ok
  end

  private

  def guest_game_params
    params.require(:guess).permit(
      :value,
    )
  end
end
