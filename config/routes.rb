Rails.application.routes.draw do
  namespace :api do
    resources :products, only: [:show, :update]
  end
end
