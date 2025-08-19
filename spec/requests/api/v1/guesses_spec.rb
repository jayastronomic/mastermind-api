require "swagger_helper"

RSpec.describe "api/v1/guesses", type: :request do
  path "/api/v1/guesses/create" do
    post "Create guess" do
      tags "Guesses"
      consumes "application/json"
      parameter name: :guess, in: :body, schema: {
        type: :object,
        properties: {
          guess: {
            type: :object,
            properties: {
              value: { type: :string },
              game_id: { type: :string, format: :uuid },
            },
            required: %w[value game_id],
          },
        },
        required: ["guess"],
      }

      response "201", "created" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        let(:game) do
          user = User.create!(username: "p", password: "secret12")
          Game.create!(user: user, solution: "0123")
        end
        let(:guess) { { guess: { value: "4567", game_id: game.id } } }
        run_test!
      end
    end
  end
end
