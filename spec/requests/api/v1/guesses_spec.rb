require "swagger_helper"

RSpec.describe "api/v1/guesses", type: :request do
  path "/api/v1/guesses/create" do
    post "Create guess" do
      tags "Guesses"
      consumes "application/json"
      security [bearerAuth: []]
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
        let(:Authorization) do
          user = User.create!(email: "p@q.com", username: "p", password: "secret12")
          game = Game.create!(user: user, solution: "0123")
          token = JWT.encode({ user_id: user.id, iss: ENV.fetch("JWT_ISSUER", "http://localhost:3000"), aud: ENV.fetch("JWT_AUDIENCE", "mastermind-api") }, ENV.fetch("JWT_SECRET", "a-string-secret-at-least-256-bits-long"), "HS256")
          @game_id = game.id
          "Bearer #{token}"
        end
        let(:guess) { { guess: { value: "4567", game_id: @game_id } } }
        run_test!
      end
    end
  end
end
