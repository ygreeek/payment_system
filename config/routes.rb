# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :merchants
  devise_for :admins

  root to: 'home#index'

  namespace :admins do
    resources :transactions, only: %i[index]
  end

  resources :merchants

  namespace :merchants do
    resources :transactions, only: %i[index]
  end
end
