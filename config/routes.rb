Rails.application.routes.draw do
  devise_for :users
  root   'static_pages#home'
  get    '/results',          to: 'static_pages#results'
  resources :kit_lists
end
