Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :auth do
        post "register", to: "auth#register"
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
