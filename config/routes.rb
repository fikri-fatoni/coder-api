Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        token_validations: 'api/v1/overrides/token_validations',
        sessions: 'api/v1/overrides/sessions'
      }
    end
    namespace :v1 do
      resources :articles
      resources :categories
      resources :rewards
      resources :schedules
      resources :users, only: [:index]
      resources :videos

      resources :roles do
        post 'assign_role', on: :collection
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
