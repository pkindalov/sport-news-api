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
    end
  end
end
