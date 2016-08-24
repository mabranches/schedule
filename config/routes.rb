Rails.application.routes.draw do
  resources :schedulings
  devise_for :users
  root to: 'schedulings#index'

end
