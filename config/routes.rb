Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :auth do
        post "register", to: "auth#register"
        get "is_logged_in", to: "auth#is_logged_in"
      end

      scope :games do
        post "create", to: "games#create"
      end

      scope :guesses do
        post "create", to: "guesses#create"
      end
    end
  end
end
