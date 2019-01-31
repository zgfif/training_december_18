Rails.application.routes.draw do
  namespace :api do
    resources :users, only: :create

    resource :session, only: %i(create destroy)

    resources :authors, only: :index
  end

  namespace :backoffice do
    resource :session, only: %i(create destroy)

    resources :authors, only: :create
  end
end
