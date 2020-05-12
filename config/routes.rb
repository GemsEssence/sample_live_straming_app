Rails.application.routes.draw do
  devise_for :users
  root 'meetings#index'

  resources :meetings
end
