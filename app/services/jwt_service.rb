module JwtService
    JWT_ISSUER = ENV.fetch("JWT_ISSUER")
    JWT_AUDIENCE = ENV.fetch("JWT_AUDIENCE")

  def encode_token(payload = {})
      payload[:iss] = JWT_ISSUER
      payload[:aud] = JWT_AUDIENCE
    JWT.encode(payload, ENV.fetch("JWT_SECRET"), "HS256")
  end

  def decode_token(request)
    header = request.headers["Authorization"]
    raise UnauthorizedError.new("No Authorization header provided.") unless header
    token = header.split(" ")[1]
    begin
      get_current_user(JWT.decode(token, ENV.fetch("JWT_SECRET"), true, { algorithm: "HS256", iss: JWT_ISSUER, verify_iss: true }))
    rescue JWT::DecodeError
      raise UnauthenticatedError
    end
  end

  def current_user
    @current_user
  end

  private

  def get_current_user(decoded_token)
    user_id = decoded_token[0]["user_id"]
    @current_user = User.find_by(id: user_id)
    @current_user ? @current_user : raise(UnauthenticatedError)
  end
end
