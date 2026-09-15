Rails.application.routes.draw do
  root "books#index"
  resources :books do
    member do
      get :delete
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
