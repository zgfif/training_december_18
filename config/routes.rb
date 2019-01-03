Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :confirmation, only: :create

  resources :users, only: :create

  resource :session, only: %i(create destroy)
end
