Rails.application.routes.draw do
  root to: 'stories#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
    get "/login" => "devise/sessions#new"
  end
  resources :comments, only: [:show,:edit, :create,:index,:destroy, :update] do
  end

  resources :comment_likes, only: [:create] do
  end

  resources :stories do
  end

  resources :story_likes, only: [:create] do
  end
end
