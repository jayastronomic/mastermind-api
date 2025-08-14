class AuthService
  def register(user_params)
    @user = User.new(user_params)
    if @user.save
      UserSerializer.new(@user).as_json
    end
  end
end
