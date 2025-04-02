Rails.application.routes.draw do
  # Devise routes for API
  devise_for :users,
             controllers: {
               sessions: "api/v1/users/sessions"
             }

  # Regular resources
  resources :contacts

  # Public routes
  root "home#index"
  get "home/about"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # API namespace
  namespace :api do
    namespace :v1 do
      resources :contacts
    end
  end
end
