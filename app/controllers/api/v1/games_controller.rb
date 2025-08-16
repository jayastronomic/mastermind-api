class Api::V1::GamesController < ApplicationController
  def initialize(game_service: GameService.new)
    @game_service = game_service
  end

  def create
    render jason: ResponseEntity.success(data: @game_service.create(game_params), message: -> { "Game created!" }), status: :created
  end

  private

  def game_params
    params.require(:game).permit(
      :user_id
    )
  end
end
