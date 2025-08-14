Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope :auth do
        post "register", to: "auth#register"
      end

      scope :game do
        post "create", to: "game#create"
      end
    end
  end
end
