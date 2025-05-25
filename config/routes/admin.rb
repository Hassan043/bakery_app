# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    root to: "dashboard#show"
    resources :products
    resources :categories
    resources :users, only: [:index]
  end
end
