Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks do
    member do
      post :sync
      patch :toggle
    end
  end
end
