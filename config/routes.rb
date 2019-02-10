Rails.application.routes.draw do
  namespace :api do
    resources :users, only: :create

    resource :session, only: %i(create destroy)

    resources :authors, only: :index
  end

  namespace :backoffice do
    resource :session, only: %i(create destroy)

<<<<<<< HEAD
    resources :authors, only: %i(index create) do
      resource :avatar, only: :create
    end
=======
    resources :authors, only: %i(index create update)

    resources :categories, only: :create
>>>>>>> ea160b59938a95421c9b0a3458400f3ce716df9b
  end
end
