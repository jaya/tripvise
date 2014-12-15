Rails.application.routes.draw do
  resources :trips, except: [:new, :edit]
  resources :users, except: [:new, :edit]
end
