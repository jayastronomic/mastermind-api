class GuessService
  def create(guess_params)
    guess = Guess.new(guess_params)

    # Validate only the value before running the game
    unless guess.valid?(:value_only)
      return { errors: guess.errors.full_messages }
    end

    # Find the associated game
    game = Game.find(guess.game_id)

    # Exit Early if game already has 10 guesses
    return { message: "Game over" } if game.guesses.length == 10

    guess.game = game
    game.break_code(guess)
    guess.save!
    game.save!

    # Return serialized
    GuessSerializer.new(guess).as_json
  end
end
