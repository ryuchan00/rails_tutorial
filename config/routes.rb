Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  # as オプションは、Urlヘルパーの名前を修正する　e.g helf_path
  # get  '/help',    to: 'static_pages#help', as: 'helf'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :change_notify, :feed
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  get '/microposts/search', to: 'microposts#search'
  resources :relationships, only: [:create, :destroy]

  # mount V1::Users => '/'
  # mount V2::Users => '/'
  mount API::Root => '/'
end

