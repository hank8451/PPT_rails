Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "boards#index"
  get "/about", to: "pages#about"
  get "/pricing", to: "pages#pricing"
  get "/payment", to: "pages#payment"
  post "/checkout", to: "pages#checkout"

  # resources :boards do
  #   resources :posts, only: [:index, :new, :create]
  # end
  # resources :posts, except: [:index, :new, :create]

  namespace :api do
    namespace :v2 do
      resources :boards, only: [:index]
    end
  end
  resources :favorites, only: [:index]
  resources :boards do
    member do
      post :favorite
      put :hide
    end

    resources :posts, shallow: true do
      resources :comments, shallow: true, only: [:create]
    end
  end

  resources :users, only: [:create] do
    # member do
    #   get :profile
    # end
    collection do
      get :sign_up
      get :edit
      patch :update
      get :sign_in
      post :login
      delete :sign_out
    end
  end
end
