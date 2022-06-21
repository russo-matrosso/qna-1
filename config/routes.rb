# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :awards, only: :index

  concern :voted do
    member do
      patch :like
      patch :dislike
      delete :cancel
    end
  end

  resources :questions, concerns: :voted do
    resources :answers, concerns: :voted, shallow: true do
      patch 'best', on: :member
    end
  end

  root to: 'questions#index'
end
