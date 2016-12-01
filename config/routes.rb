Rails.application.routes.draw do
  root                         to: 'sessions#show'
  get  '/auth/slack/callback', to: 'sessions#create'
  post '/logout',              to: 'sessions#destroy'
  get  '/sign_in_with_slack',  to: 'sessions#new'

  resources :companies,         only: [:index, :show, :new, :create]
  resources :cities,            only: [:index, :show]
  resources :starred_companies, only: [:index, :create, :destroy]
end
