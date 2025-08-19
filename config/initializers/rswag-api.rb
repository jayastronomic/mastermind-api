Rswag::Api.configure do |c|
  # Serve swagger files from the /swagger directory in the app root
  c.openapi_root = Rails.root.join("swagger").to_s

  # Optionally filter/transform the spec
  # c.swagger_filter = lambda { |swagger, env| swagger }
end
