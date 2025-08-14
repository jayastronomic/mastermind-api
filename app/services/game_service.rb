class GameService
  def initialize(rand_gen_service: RandGenService.new)
    @rand_gen_service = rand_gen_service
  end

  def create(game_params)
    @game = Game.new(game_params)
    @game.solution = @rand_gen_service.get_random_number
    GameSerializer.new(@game).as_json if @game.save!
  end
end
