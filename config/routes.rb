# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :topics, only: [:index, :show, :create, :update, :destroy]
      resources :flashcards, only: [:index, :create, :update, :destroy]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
