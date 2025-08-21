class GameService
  def initialize(rand_gen_service: RandGenService.new)
    @rand_gen_service = rand_gen_service
  end

  def create(game_params)
    game = Game.new(game_params)
    game.solution = @rand_gen_service.get_random_number
    GameSerializer.new(game).as_json if game.save!
  end

  def find(params)
    user = User.find(params[:user_id])
    current_game = user.last_game
    GameSerializer.new(current_game).as_json
  end

  def delete(params)
    current_game = Game.find(params[:id])
    current_game.destroy
    GameSerializer.new(current_game).as_json
  end

  private

  def get_current_user(id)
    User.find(id)
  end
end
