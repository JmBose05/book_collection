Rails.application.routes.draw do
  resources :user_books
  resources :users
  root "user_books#index"
  resources :books
  get "up" => "rails/health#show", as: :rails_health_check
end
