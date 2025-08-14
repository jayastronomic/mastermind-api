class AuthService
  def register(user_params)
    @user = User.new(user_params)
    if @user.save
      @user
    end
  end
end
