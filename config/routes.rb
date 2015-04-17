Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :books
  root to: "books#index"

  resources :books do
    resources :notes, only: [:create, :destroy]
  end

  resources :sessions, only: [:create, :destroy, :new]

  get '/login' => "sessions#new", as: "login"
  delete '/logout' => "sessions#destroy", as: "logout"

end