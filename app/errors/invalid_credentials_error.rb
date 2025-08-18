class InvalidCredentialsError < StandardError
  def message
    "Invalid credentials"
  end
end
