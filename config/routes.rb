Rails.application.routes.draw do
  resources :recommendations, except: [:new, :edit]
  resources :trips, except: [:new, :edit]
  resources :users, except: [:new, :edit]
  post '/users/:id/email', to: 'users#send_email'
  post '/users/:id/redeem', to: 'users#redeem'
  get '/users/:id/recommendation_requests', to: 'users#recommendation_requests'
  get '/users/:id/recommendations', to: 'users#my_recommendations'
end
