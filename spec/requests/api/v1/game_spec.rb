require 'rails_helper'

RSpec.describe "GamesController", type: :request do
  describe "POST /api/v1/game/create" do
    let(:user) { User.create!(email: "test@example.com", username: "TestUser") }

    let(:valid_params) do
      {
        game: {
          user_id: user.id
        }
      }
    end

    let(:invalid_params) do
      {
        game: {
          user_id: nil
        }
      }
    end

    context "when valid game data is provided" do
      it "creates a new game for a given user" do
        expect {
          post "/api/v1/game/create", params: valid_params, as: :json
        }.to change(Game, :count).by(1)
      end

      it "returns a 201 status" do
        post "/api/v1/game/create", params: valid_params, as: :json
        expect(response).to have_http_status(:created)
      end

      it "returns the created game data in JSON" do
        post "/api/v1/game/create", params: valid_params, as: :json
        json = JSON.parse(response.body)

        expect(json["id"]).to be_present
        expect(json["status"]).to eq("in_progress")
        expect(json["userId"]).to eq(user.id)
      end
    end

    context "when invalid data is provided" do
      it "does not create a new game" do
        expect {
          post "/api/v1/game/create", params: invalid_params, as: :json
        }.not_to change(Game, :count)
      end

      it "returns a 422 status" do
        post "/api/v1/game/create", params: invalid_params, as: :json
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "returns validation errors" do
        post "/api/v1/game/create", params: invalid_params, as: :json
        json = JSON.parse(response.body)
        expect(json["errors"]).to be_present
      end
    end
  end
end
