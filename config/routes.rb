Rails.application.routes.draw do
  devise_for :users

  get '/watch/:id', to: 'streams#watch', as: :watch
  get '/live_streaming', to: 'streams#live_streaming', as: :live_streaming

  root 'streams#live_streaming'
end
