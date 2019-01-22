Rails.application.routes.draw do
  namespace :api do
    resources :users, only: :create

    resource :session, only: %i(create destroy)
  end

  namespace :backoffice do
    resource :session, only: :create
  end
end
