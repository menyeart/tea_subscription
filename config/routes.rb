Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [] do
        resources :subscriptions, only: %i[create update index], controller: 'customers/subscriptions'
      end
    end
  end
end
