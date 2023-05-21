# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/users/login', to: 'users#login'
  resources :users, only: %i[index show create]
  resources :alerts, only: %i[index show create destroy]
  get '/users/:user_id/alerts', to: 'alerts#user_alert'
end
