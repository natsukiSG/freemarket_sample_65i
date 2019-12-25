Rails.application.routes.draw do
  resources :users, only: [:show] 
  resources :toppage, only: [:index]
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppage#index'
end
