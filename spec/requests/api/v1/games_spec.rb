require "swagger_helper"

RSpec.describe "api/v1/games", type: :request do
  path "/api/v1/games/create" do
    post "Create game" do
      tags "Games"
      consumes "application/json"
      security [bearerAuth: []]
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          game: {
            type: :object,
            properties: { user_id: { type: :string, format: :uuid } },
            required: %w[user_id],
          },
        },
        required: ["game"],
      }

      response "201", "created" do
        schema "$ref" => "#/components/schemas/ResponseEntity"

        let(:user) do
          User.create!(email: "g2@u.com", username: "g2", password: "secret12")
        end
        let(:Authorization) do
          user = User.create!(email: "g@u.com", username: "g", password: "secret12")
          token = JWT.encode({ user_id: user.id, iss: ENV.fetch("JWT_ISSUER", "http://localhost:3000"), aud: ENV.fetch("JWT_AUDIENCE", "mastermind-api") }, ENV.fetch("JWT_SECRET", "a-string-secret-at-least-256-bits-long"), "HS256")
          "Bearer #{token}"
        end
        let(:game) { { game: { user_id: User.last.id } } }
        run_test!
      end
    end
  end

  path "/api/v1/games/{user_id}" do
    get "Find latest game" do
      tags "Games"
      produces "application/json"
      security [bearerAuth: []]
      parameter name: :user_id, in: :path, type: :string

      response "200", "ok" do
        schema "$ref" => "#/components/schemas/ResponseEntity"

        let(:user) do
          User.create!(email: "g2@u.com", username: "g2", password: "secret12")
        end

        let(:Authorization) do
          Game.create!(user: user, solution: "0123")
          token = JWT.encode(
            { user_id: user.id, iss: ENV.fetch("JWT_ISSUER", "http://localhost:3000"),
              aud: ENV.fetch("JWT_AUDIENCE", "mastermind-api") },
            ENV.fetch("JWT_SECRET", "a-string-secret-at-least-256-bits-long"),
            "HS256"
          )
          "Bearer #{token}"
        end

        let(:user_id) { user.id }
        run_test!
      end
    end
  end
end
