# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  resources :screenings do
    resources :reservations, only: %i[new create] do
      collection do
        post 'create_at_desk', to: 'reservations#create_at_desk'
        post 'create_without_registration', to: 'reservations#create_without_registration'
      end
    end
  end
  resources :movies
  resources :halls
  resources :promotions, only: %i[index]
  resources :reservations, except: %i[show new create] do
    patch 'cancel', to: 'reservations#cancel'
    patch 'confirm', to: 'reservations#confirm'
  end
end
