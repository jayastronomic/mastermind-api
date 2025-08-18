require "swagger_helper"

RSpec.describe "api/v1/guest_games", type: :request do
  # Guest endpoints are public; ensure no auth header is sent
  let(:Authorization) { nil }
  path "/api/v1/guest_games/create" do
    post "Create guest game" do
      tags "GuestGames"
      produces "application/json"

      response "200", "created guest game" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        run_test!
      end
    end
  end

  path "/api/v1/guest_games/find/{session_id}" do
    get "Find guest game" do
      tags "GuestGames"
      produces "application/json"
      parameter name: :session_id, in: :path, type: :string

      response "200", "found" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        let(:session_id) do
          # create first
          post "/api/v1/guest_games/create"
          JSON.parse(response.body).dig("data", "id") || "nonexistent"
        end
        run_test!
      end
    end
  end

  path "/api/v1/guest_games/guess/{session_id}" do
    post "Make a guess (guest)" do
      tags "GuestGames"
      consumes "application/json"
      parameter name: :session_id, in: :path, type: :string
      parameter name: :guess, in: :body, schema: {
        type: :object,
        properties: {
          guess: { type: :object, properties: { value: { type: :string } }, required: ["value"] },
        },
        required: ["guess"],
      }

      response "201", "guess accepted" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        let(:session_id) do
          post "/api/v1/guest_games/create"
          JSON.parse(response.body).dig("data", "user_id")
        end
        let(:guess) { { guess: { value: "0123" } } }
        run_test!
      end
    end
  end
end
