Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :auth do
        post "register", to: "auth#register"
        post "login", to: "auth#login"
        get "is_logged_in", to: "auth#is_logged_in"
      end

      scope :games do
        post "create", to: "games#create"
        get  "/:user_id", to: "games#find"
      end

      scope :guest_games do
        post "create", to: "guest_games#create"
        get "find/:session_id", to: "guest_games#find"
        post "guess/:session_id", to: "guest_games#guess"
      end

      scope :guesses do
        post "create", to: "guesses#create"
      end
    end
  end
end
