Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources(:cats) do
    resources(:rental_requests, only: [:create, :new, :update])
  end
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
