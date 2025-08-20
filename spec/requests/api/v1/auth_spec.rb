require "swagger_helper"

RSpec.describe "api/v1/auth", type: :request do
  path "/api/v1/auth/register" do
    post "Register user" do
      tags "Auth"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              username: { type: :string },
              password: { type: :string },
            },
            required: %w[username password],
          },
        },
        required: ["user"],
      }

      response "201", "registered" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        let(:user) { { user: { username: "john", password: "secret12" } } }
        run_test!
      end

      response "422", "unprocessable content" do
        schema type: :object,
          properties: {
            message: { type: :string, example: "Validation failed: Username has already been taken" },
            errors: {
              type: :object,
              properties: {
                username: {
                  type: :array,
                  items: { type: :string },
                  example: ["has already been taken"],
                },
              },
            },
          },
          required: %w[message errors]

        before do
          User.create!(username: "john", password: "secret12")
        end

        let(:user) { { user: { username: "john", password: "secret12" } } }
        run_test!
      end
    end
  end

  path "/api/v1/auth/login" do
    post "Login" do
      tags "Auth"
      consumes "application/json"
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              username: { type: :string },
              password: { type: :string },
            },
            required: %w[username password],
          },
        },
        required: ["user"],
      }

      response "200", "authenticated" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        before do
          User.create!(username: "john", password: "secret12")
        end
        let(:user) { { user: { username: "john", password: "secret12" } } }
        run_test!
      end
    end
  end

  path "/api/v1/auth/is_logged_in/{user_id}" do
    get "Get auth user" do
      tags "Auth"
      parameter name: :user_id, in: :path, type: :string

      response "200", "ok" do
        schema "$ref" => "#/components/schemas/ResponseEntity"
        let(:user_id) do
          user = User.create!(username: "x", password: "secret12")
          user.id
        end

        run_test!
      end
    end
  end
end
