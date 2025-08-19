class AuthService < ApplicationService
  def register(user_params)
    user = User.create!(user_params)
    [encode_token(user_id: user.id), user]
  end

  def login(user_params)
    user = User.find_by(username: user_params[:username])
    raise InvalidCredentialsError unless user && user.authenticate(user_params[:password])
    [encode_token(user_id: user.id), user]
  end

  def is_logged_in(params)
    UserSerializer.new(User.find(params[:user_id])).as_json
  end
end
