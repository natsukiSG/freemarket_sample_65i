Rails.application.routes.draw do
  get 'users/show'
  root to: 'tops#index'
  get 'tops/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
