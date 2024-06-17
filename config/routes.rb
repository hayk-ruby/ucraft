Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:update] do 
        collection do
          get   :get_user_details
          post  :check_logged_user
          patch :update_user_details
        end
      end

      devise_for :users, controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
