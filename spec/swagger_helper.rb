require "rails_helper"

RSpec.configure do |config|
  config.swagger_root = Rails.root.join("swagger").to_s

  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "Mastermind API",
        version: "v1",
      },
      servers: [
        { url: "http://localhost:3000" },
      ],
      components: {
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: "JWT",
          },
        },
        schemas: {
          ResponseEntity: {
            type: :object,
            properties: {
              status: { type: :string, example: "success" },
              message: { type: :string, example: "OK" },
              data: {},
              errors: {},
            },
            required: %w[status message],
          },
        },
      },
      security: [{ bearerAuth: [] }],
    },
  }

  config.swagger_format = :yaml
end
