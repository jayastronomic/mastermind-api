require "swagger_helper"

RSpec.describe "api/v1/auth", type: :request do
  path "/api/v1/auth/register" do
    post "Register user" do
      security []
      tags "Auth"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              username: { type: :string },
              password: { type: :string },
            },
            required: %w[email username password],
          },
        },
        required: ["user"],
      }

      response "201", "registered" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        let(:user) { { user: { email: "a@b.com", username: "john", password: "secret12" } } }
        run_test!
      end
    end
  end

  path "/api/v1/auth/login" do
    post "Login" do
      security []
      tags "Auth"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
            },
            required: %w[email password],
          },
        },
        required: ["user"],
      }

      response "200", "authenticated" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        before do
          User.create!(email: "a@b.com", username: "john", password: "secret12")
        end
        let(:user) { { user: { email: "a@b.com", password: "secret12" } } }
        run_test!
      end
    end
  end

  path "/api/v1/auth/is_logged_in" do
    get "Check auth" do
      tags "Auth"
      security [bearerAuth: []]

      response "200", "ok" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        let(:Authorization) do
          token = JWT.encode({ user_id: User.create!(email: "x@y.com", username: "x", password: "secret12").id,
                               iss: ENV.fetch("JWT_ISSUER", "http://localhost:3000"),
                               aud: ENV.fetch("JWT_AUDIENCE", "mastermind-api") },
                             ENV.fetch("JWT_SECRET", "a-string-secret-at-least-256-bits-long"), "HS256")
          "Bearer #{token}"
        end
        run_test!
      end
    end
  end
end
