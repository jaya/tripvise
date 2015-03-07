Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root 'landing_page#index'

  resources :recommendations, except: [:new, :edit]
  resources :trips, except: [:new, :edit]
  resources :users, except: [:new, :edit]
  post '/users/:id/email', to: 'users#send_email'
  post '/users/:id/redeem', to: 'users#redeem'
  get '/users/:id/recommendation_requests', to: 'users#recommendation_requests'
  get '/users/:id/recommendations', to: 'users#my_recommendations'
  get '/trips/:id/recommendations', to: 'trips#recommendations'
  post '/recommendations/:id/wishlist', to: 'recommendations#wishlist'
  put '/trips/:id/update_picture', to: 'trips#update_destination_picture'
end
