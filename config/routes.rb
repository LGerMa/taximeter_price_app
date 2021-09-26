Rails.application.routes.draw do
  resources :companies do
    resources :taximeters
  end

  get '/search', to: 'searches#index'
  post '/search', to: 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
