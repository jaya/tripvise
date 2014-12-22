Rails.application.routes.draw do
  resources :recommendations, except: [:new, :edit]
  resources :trips, except: [:new, :edit]
  resources :users, except: [:new, :edit]
end
