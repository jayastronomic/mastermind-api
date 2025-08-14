require 'rails_helper'

RSpec.describe "User", type: :request do
  describe "POST /api/v1/auth/register" do
    let(:valid_params) do
      {
        user: {
          email: "test@example.com",
          username: "TestUsername"
        }
      }
    end

    let(:invalid_params) do
      {
        user: {
          email: "", # blank email
          username: "TestUsername"
        }
      }
    end

    context "when valid data is provided" do
      it "creates a new user" do
        expect {
          post "/api/v1/auth/register", params: valid_params
        }.to change(User, :count).by(1)
      end

      it "returns a 201 status" do
        post "/api/v1/auth/register", params: valid_params
        expect(response).to have_http_status(:created)
      end

      it "returns the created user data in JSON" do
        post "/api/v1/auth/register", params: valid_params
        json = JSON.parse(response.body)
        expect(json["email"]).to eq("test@example.com")
        expect(json["username"]).to eq("TestUsername")
      end
    end

    context "when invalid data is provided" do
      it "does not create a new user" do
        expect {
          post "/api/v1/auth/register", params: invalid_params
        }.not_to change(User, :count)
      end

      it "returns a 422 status" do
        post "/api/v1/auth/register", params: invalid_params
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "returns validation errors" do
        post "/api/v1/auth/register", params: invalid_params
        json = JSON.parse(response.body)
        expect(json["errors"]).to be_present
      end
    end
  end
end
