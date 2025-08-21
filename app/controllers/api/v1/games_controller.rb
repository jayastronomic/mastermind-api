class Api::V1::GamesController < ApplicationController
  def initialize(game_service: GameService.new)
    @game_service = game_service
  end

  def create
    render json: ResponseEntity.success(data: @game_service.create(game_params), message: -> { "Game created!" }), status: :created
  end

  def find
    render json: ResponseEntity.success(data: @game_service.find(params), message: -> { "Game found!" }), status: :ok
  end

  def delete
    render json: ResponseEntity.success(data: @game_service.delete(params), message: -> { "Game deleted!" }), status: :ok
  end

  private

  def game_params
    params.require(:game).permit(
      :user_id
    )
  end
end
