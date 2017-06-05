Rails.application.routes.draw do
  get '/', to: 'home#index', as: 'root'
  post '/check', to: 'cards#check', as: 'check'
  resources :cards

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
