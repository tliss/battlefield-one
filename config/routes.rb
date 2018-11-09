Rails.application.routes.draw do
  devise_for :users
  root   'static_pages#home'
  get    '/process_kit_list',          to: 'kit_lists#process_kit_list'
  resources :kit_lists
  resources :kit_list_users
end
