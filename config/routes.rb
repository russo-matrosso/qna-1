# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :attachments, only: :destroy

  resources :questions do
    resources :answers, shallow: true do
      patch 'best', on: :member
    end
  end

  root to: 'questions#index'
end
