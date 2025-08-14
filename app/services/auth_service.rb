class AuthService
  def register(user_params)
    @user = User.new(user_params)
    UserSerializer.new(@user).as_json if @user.save!
  end
end
