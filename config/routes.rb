Rails.application.routes.draw do
  root to: 'stories#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
    get "/login" => "devise/sessions#new"
  end
  resources :comments do
  end

  resources :stories do
  end
end
