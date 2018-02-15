Rails.application.routes.draw do
  namespace :api do
    get 'products/show'
  end

  namespace :api do
    get 'products/update'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
