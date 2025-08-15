class InvalidCredentialsError < StandardError
  def message
    "Invalid email/password"
  end
end
