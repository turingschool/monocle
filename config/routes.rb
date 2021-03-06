Rails.application.routes.draw do
  root                            to: 'sessions#show'
  get  '/auth/:provider/callback',    to: 'sessions#create'
  post '/logout',                 to: 'sessions#destroy'
  get  '/sign_in_with_census',    to: 'sessions#new'
  get  'companies/notes/delete',  to: 'notes#destroy'

  resources :companies,         only: [:index, :show, :new, :create] do
    resources :notes,           only: [:create, :edit, :update, :destroy]
    resources :locations,       only: [:new, :create, :edit, :update, :destroy]
  end

  resources :starred_companies, only: [:create, :destroy]
  resources :favorites, only: [:index]
  resources :starred_jobs, only: [:create, :destroy]

  resources :jobs, only: [:index, :show]
  resources :findings, only: [:new, :create]
  resources :technologies, only: [:index]

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

  resources :notes, only: [:index, :new, :create]
  resources :employed_alumni, only: [:index]

  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :census_users, only: [:index]
      end
      get '/companies/find', to: 'company_search#show', as: 'find_company'
      resources :companies,       only: [:index, :create] do
        resources :employees,     only: [:create, :destroy]
        resources :locations,     only: [:index, :update]
        namespace :admin do
          resources :employees,   only: [:create]
        end
      end
      resources :notes, only: [:index, :create, :update, :destroy]
    end
  end
end
