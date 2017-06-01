Rails.application.routes.draw do
  get '/', to: 'home#index'
  #get '/cards', to: 'cards#index'
  resources :cards

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
