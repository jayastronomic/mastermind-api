class GuestGameService < ApplicationService
  def initialize(rand_gen_service: RandGenService.new)
    @rand_gen_service = rand_gen_service
  end


  def create
    solution = @rand_gen_service.get_random_number
    session_id = SecureRandom.uuid
    game = Game.new(solution: solution, user_id: session_id)

    # Store the game in memory (e.g., Rails cache)
    Rails.cache.write("guest_game_#{session_id}", game, expires_in: 1.hour)
    GameSerializer.new(game).as_json
  end

  def find(params)
    session_id = params[:session_id]
    game = Rails.cache.read("guest_game_#{session_id}")
    if game.nil?
      create
    else
      GameSerializer.new(game).as_json
    end
  end



  def guess(params, session_id)
        guess = Guess.new(value: params[:value])

        game = Rails.cache.read("guest_game_#{session_id}")
        unless game
          raise GuestGameNotFoundError
        end

        return { message: "Game Over" } if game.guesses.length == 10

        game.break_code(guess)
        Rails.cache.write("guest_game_#{session_id}", game, expires_in: 1.hour)
        GuessSerializer.new(guess).as_json
  end

  def delete(params)
    session_id = params[:session_id]
    Rails.cache.delete("guest_game_#{session_id}")
  end
end
