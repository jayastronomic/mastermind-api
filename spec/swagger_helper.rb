require "rails_helper"

RSpec.configure do |config|
  config.openapi_root = Rails.root.join("swagger").to_s

  config.openapi_specs = {
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
    },
  }

  config.openapi_format = :yaml
end
