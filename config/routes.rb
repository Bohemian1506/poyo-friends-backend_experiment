Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      get "health", to: "health#index"

      namespace :auth do
        devise_for :users,
                    controllers: {
                    registrations: 'api/v1/auth/registrations',
                    sessions: 'api/v1/auth/sessions'
                  }
      end

      resource :user, only: [:show, :update], path: 'users/me'
    end
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
