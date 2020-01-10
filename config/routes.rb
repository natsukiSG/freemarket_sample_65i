Rails.application.routes.draw do
  root to: 'toppage#index'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions:      "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users , only: [:index] do
    collection do
      get 'logout'
      get 'info_check'
    end
  end

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



  
  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      delete 'delete', to: 'card#delete'
    end
  end

  resources :toppage do
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

  resources :products do
    member do
      get 'buy_confirmation'

      post 'pay'
      get 'done', to:'products#done'

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

  post   '/like/:product_id' => 'likes#like',   as: 'like'
  delete '/like/:product_id' => 'likes#unlike', as: 'unlike'

end

