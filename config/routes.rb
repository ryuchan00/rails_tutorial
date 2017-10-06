Rails.application.routes.draw do
  root 'static_pages#home'

  get  '/help',    to: 'static_pages#help'
  # as オプションは、Urlヘルパーの名前を修正する　e.g helf_path
  # get  '/help',    to: 'static_pages#help', as: 'helf'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  get  '/signup',  to: 'users#new'
end
