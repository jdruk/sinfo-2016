Rails.application.routes.draw do
  get 'notifications/create'

  get 'checkout/create': 'checkout#create', as: :create

  get 'dashboard/index': 'dashboard#index', as: :index

  get 'dashboard/admininstrator': 'dashboard#admininstrator', as: :admininstrator

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :courses
end
