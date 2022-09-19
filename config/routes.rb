# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  resources :screenings do
    resources :reservations
  end
  resources :movies
  resources :halls
end
