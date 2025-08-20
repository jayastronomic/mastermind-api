module JwtService
  JWT_ISSUER = ENV.fetch("JWT_ISSUER")
  JWT_AUDIENCE = ENV.fetch("JWT_AUDIENCE")
  JWT_SECRET = ENV.fetch("JWT_SECRET")

  def encode_token(payload = {})
    payload[:iss] = JWT_ISSUER
    payload[:aud] = JWT_AUDIENCE
    JWT.encode(payload, JWT_SECRET, "HS256")
  end
end
