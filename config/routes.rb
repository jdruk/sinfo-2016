Rails.application.routes.draw do
  resources :contacts
  # Rotas referentes ao Pag Seguro
  post 'notifications' => 'notifications#create', as: :create_notification
  get 'checkout/create' => 'checkout#create', as: :create

  # Index principal do sistema
  root 'dashboard#index'
  get 'dashboard/index' => 'dashboard#index', as: :index

  # Painel administrativo
  get 'dashboard/admininstrator' => 'dashboard#admininstrator', as: :admininstrator

  # Rotas para sessions e registrations passando pela views geradas do devise
  devise_for :users, :controllers  => {
             :registrations => 'users/registrations',
             :sessions => 'users/sessions'
  }
  # Demais modelos
  resources :courses
end
