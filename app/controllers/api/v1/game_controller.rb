class Api::V1::GameController < ApplicationController
  def initialize(game_service: GameService.new)
    @game_service = game_service
  end

  def create
    render json: @game_service.create(game_params), status: :created
  end

  private

  def game_params
    params.require(:game).permit(
      :user_id
    )
  end
end
