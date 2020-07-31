Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "boards#index"
  get "/about" ,to: "pages#about"

  # resources :boards do
  #   resources :posts, only: [:index, :new, :create]
  # end
  # resources :posts, except: [:index, :new, :create]

  resources :boards do
    resources :posts, shallow: true
  end

  resources :users, only:[:create] do
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
