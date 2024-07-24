# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'register', to: 'auth#register'
      post 'login', to: 'auth#login'
      put 'profile', to: 'users#update'
      delete 'profile', to: 'users#destroy'
      delete 'profile/avatar', to: 'users#destroy_avatar'
      get 'users/list', to: 'users#list'

      resources :sport_categories, only: %i[create index show update destroy] do
        resources :teams, only: %i[create update destroy] do
          resources :news_articles, only: %i[create index show update destroy]
        end
      end

      resources :teams, only: %i[index show]

    end
  end
end
