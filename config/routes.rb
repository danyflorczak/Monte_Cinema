# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  resources :screenings do
    resources :reservations, only: %i[new create]
  end
  resources :movies
  resources :halls
  resources :reservations, excep: %i[show new create]
  post 'screenings/:screening_id/reservations/at_desk', to: 'reservations#create_at_desk', as: 'reservation_at_desk'
  patch 'reservations/:reservation_id/cancel', to: 'reservations#cancel', as: 'cancel_reservation'
  patch 'reservations/:reservation_id/confirm', to: 'reservations#confirm', as: 'confirm_reservation'
end
