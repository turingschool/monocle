Rails.application.routes.draw do
  root                            to: 'sessions#show'
  get  '/auth/:provider/callback',    to: 'sessions#create'
  post '/logout',                 to: 'sessions#destroy'
  get  '/sign_in_with_slack',     to: 'sessions#new'
  get  '/sign_in_with_census',    to: 'sessions#new'
  get  'companies/notes/delete',  to: 'notes#destroy'
  get  '/api/v1/notes',           to: 'api/v1/notes#index'

  resources :companies,         only: [:index, :show, :new, :create] do
    resources :notes,           only: [:create, :edit, :update, :destroy]
    resources :locations,       only: [:new, :create, :edit, :update, :destroy]
  end

  resources :starred_companies, only: [:create, :destroy]
  resources :favorites, only: [:index]

  resources :starred_jobs, only: [:create, :destroy]

  resources :jobs, only: [:index, :show]

  namespace :moderator do
    resources :companies,       only: [:edit, :update]
    resources :locations,       only: [:edit, :update]
    get 'companies/approval',   to: 'companies#index'
  end

  namespace :admin do
    resources :companies,       only: [:edit, :update]
    resources :locations,       only: [:edit, :update, :destroy]
    get 'companies/approval',   to: 'companies#index'
  end

  namespace :api do
    namespace :v1 do
      resources :companies,     only: [:index]
    end
  end
end
