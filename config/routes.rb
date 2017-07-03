Rails.application.routes.draw do

  scope module: 'home' do
    get '/', to: 'welcome#index', as: 'root'
    get 'signup', to: 'users#new', as: :signup
    get 'login', to: 'user_sessions#new', as: :login
    post 'oauth/callback', to: 'oauths#callback'
    get 'oauth/callback', to: 'oauths#callback'
    get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
    resources :users, only: [:new, :create]
    resources :user_sessions, only: [:new, :create]
  end

  scope module: 'dashboard' do
    get '/review', to: 'home#index', as: :review
    post '/check', to: 'cards#check', as: :check
    get '/current', to: 'packs#current', as: :current
    resources :packs do
      resources :cards
    end
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :user_sessions, only: [:destroy]
    post '/current_pack', to: 'users#current_pack', as: :current_pack
    post 'logout', to: 'user_sessions#destroy', as: :logout
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
