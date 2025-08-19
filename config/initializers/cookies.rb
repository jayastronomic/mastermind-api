# Configure cookie settings for JWT tokens
Rails.application.config.session_store :cookie_store,
  key: "_mastermind_session",
  secure: Rails.env.production?,
  httponly: true,
  same_site: :lax

# Configure signed cookies for JWT tokens
Rails.application.config.action_dispatch.signed_cookie_salt = "mastermind_jwt_salt"
Rails.application.config.action_dispatch.encrypted_cookie_salt = "mastermind_jwt_encrypted_salt"
Rails.application.config.action_dispatch.encrypted_signed_cookie_salt = "mastermind_jwt_encrypted_signed_salt"
