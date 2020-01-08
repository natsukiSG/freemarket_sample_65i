Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'users/show'

  resources :toppages do
    member do
      get 'buy_confirmation'
      post 'onetimebuy'
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'get_brand', defaults: { format: 'json' }
      get 'get_searchsize', defaults: { format: 'json' }
      get 'search'
      match 'search' => 'products#search', via: [:get, :post]
    end
    resources :creditcards, except: [:index, :new, :create, :edit, :show, :update, :destroy] do
      collection do
        post 'buy', to: 'creditcards#buy'
      end
    end
  end

  resources :categories , only: [:index, :show]do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :brands , only: [:index, :show]

  resources :brand_categories , only: [:show]


  devise_for :users
end
