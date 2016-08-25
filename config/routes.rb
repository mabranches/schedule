Rails.application.routes.draw do
  resources :schedulings, only: [:create, :index, :destroy]
  devise_for :users
  root to: 'schedulings#index'

end
