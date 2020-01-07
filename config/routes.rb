Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  root to: 'toppage#index'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions:      "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get     "index",               to: "users/registrations#index"
    get     "profile",             to: "users/registrations#profile"
    get     "sms",                 to: "users/registrations#sms"
    get     "sms_confirmation",    to: "users/registrations#sms_confirmation"
    get     "address",             to: "users/registrations#address"
    get     "credit",              to: "users/registrations#credit"
    get     "done",                to: "users/registrations#done"
  end
  
  resources :users, only: [:show, :edit]
  resources :toppage, only: [:index]
  
  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      delete 'delete', to: 'card#delete'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      post 'done', to: 'purchase#done'
    end
  end

  resources :products do
    member do
      get 'buy_confirmation'
      post 'pay'
      get 'done', to:'products#done'

    end
  end


end

