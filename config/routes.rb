Rails.application.routes.draw do
  namespace :api do
    resources :users, only: :create

    resource :session, only: %i(create destroy)

    resources :authors, only: :index
  end

  namespace :backoffice do
    resource :session, only: %i(create destroy)

    resource :categories, only: :create

    resources :authors, only: %i(index create update) do
      resource :avatar, only: :create
    end
  end
end
