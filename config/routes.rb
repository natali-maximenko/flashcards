Rails.application.routes.draw do
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  get '/', to: 'home#index', as: 'root'
  post '/check', to: 'cards#check', as: 'check'
  get '/current', to: 'packs#current', as: :current
  resources :packs do
    resources :cards
  end

  post '/current_pack', to: 'users#current_pack', as: :current_pack
  resources :user_sessions
  resources :users

  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
