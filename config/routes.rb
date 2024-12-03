Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :artworks, only: [:index, :show, :new, :destroy, :create] do
    collection do
      get '/my-artworks', to: "artworks#owner_index", as: :owner
    end
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index] do
    member do
      patch '/checkout', to: "bookings#checkout"
      patch '/accept', to: "bookings#accept"
      patch '/decline', to: "bookings#decline"
    end
    collection do
      get '/my-bookings', to: "bookings#owner_index", as: :owner
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

end
