class GuessService
  def create(guess_params)
    guess = Guess.new(guess_params)

    # Validate only the value before running the game
    unless guess.valid?(:value_only)
      return { errors: guess.errors.full_messages }
    end

    # Find the associated game
    game = Game.find(guess.game_id)

    guess.game = game

    # Generate the report using the game
    report = game.break_code(guess.value)

    # Assign the report to the guess
    guess.report = report.to_s

    # Save the guess (now report is present, so full validations pass)
    guess.save!

    # Return serialized
    GuessSerializer.new(guess).as_json
  end
end
