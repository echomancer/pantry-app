Rails.application.routes.draw do
  resources :foods
  resources :producers
  resources :stores
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get '/about' => 'high_voltage/pages#show', id: 'about'
end
