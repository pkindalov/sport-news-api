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

      get 'sport_categories/allUsersCategories', to: 'sport_categories#all_users_categories'
      get 'teams/allUsersTeams', to: 'teams#all_users_teams'
      resources :sport_categories, only: %i[create index show update destroy] do
        resources :teams, only: %i[create update destroy] do
          member do
            get 'news', to: 'teams#news'
          end
          resources :news_articles, only: %i[create index show update destroy]
        end
      end

    end
  end
end
