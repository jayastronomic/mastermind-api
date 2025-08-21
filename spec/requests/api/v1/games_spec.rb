require "swagger_helper"

RSpec.describe "api/v1/games", type: :request do
  path "/api/v1/games/create" do
    post "Create game" do
      tags "Games"
      consumes "application/json"
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
          User.create!(username: "g2", password: "secret12")
        end

        let(:game) { { game: { user_id: user.id } } }
        run_test!
      end
    end
  end

  path "/api/v1/games/{user_id}" do
    get "Find latest game" do
      tags "Games"
      produces "application/json"
      parameter name: :user_id, in: :path, type: :string

      response "200", "ok" do
        schema "$ref" => "#/components/schemas/ResponseEntity"

        let(:user) do
          User.create!(username: "g2", password: "secret12")
        end

        let(:user_id) { user.id }

        before do
          Game.create!(user: user, solution: "0123")
        end
        run_test!
      end
    end
  end

  path "/api/v1/games/{id}" do
    delete "Delete game" do
      tags "Games"
      produces "application/json"
      parameter name: :id, in: :path, type: :string

      response "200", "ok" do
        schema "$ref" => "#/components/schemas/ResponseEntity"

        let(:user) do
          User.create!(username: "g2", password: "secret12")
        end

        let(:id) do
          game = Game.create!(user: user, solution: "0123")
          game.id
        end

        run_test!
      end
    end
  end
end
