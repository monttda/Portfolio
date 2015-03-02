Rails.application.routes.draw do
  root to: 'stories#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
    get "/login" => "devise/sessions#new"
  end
  resources :comments, only: [:show,:edit, :create,:index,:destroy, :update] do
    get 'user_comments', to: 'comments#user_comments', on: :collection
  end

  resources :comment_likes, only: [:create] do
  end

  resources :stories do
    get 'user_stories', to: 'stories#user_stories', on: :collection
  end

  resources :story_likes, only: [:create] do
  end
end
