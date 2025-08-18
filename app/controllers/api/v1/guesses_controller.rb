class Api::V1::GuessesController < ApplicationController
  def initialize(guess_service: GuessService.new)
    @guess_service = guess_service
  end

  def create
    render json: ResponseEntity.success(data: @guess_service.create(guess_params), message: -> { "Guess created!" }), status: :created
  end

  private

  def guess_params
    params.require(:guess).permit(
      :value,
      :game_id
    )
  end
end
