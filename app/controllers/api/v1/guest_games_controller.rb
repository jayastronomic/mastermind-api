class Api::V1::GuestGamesController < ApplicationController
  skip_before_action :authorized?

  def initialize(guest_game_service: GuestGameService.new)
      @guest_game_service = guest_game_service
  end

  def create
    render json: ResponseEntity.success(data: @guest_game_service.create, message: -> { "Game Created!" }), status: :ok
  end

  def show
    render json: ResponseEntity.success(data: @guest_game_service.show(params), message: -> { "Game Fetched!" }), status: :ok
  end

  def guess
    render json: ResponseEntity.success(data: @guest_game_service.guess(params), message: -> { "Guess Attempt!" }), status: :ok
  end

  private
  def guest_game_params
    params.require(:guest_game).permit(
      :value,
    )
  end
end
