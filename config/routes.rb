Rails.application.routes.draw do
  get 'certificate/create_certificate'

  resources :articles
  get 'rodape/rodape'
  
  get 'topo/login'

  get 'topo/logout'

  get 'artigo/index'

  get 'minicursos/index'

  get 'home/index'

  resources :contacts
  # Rotas referentes ao Pag Seguro
  post 'notifications' => 'notifications#create', as: :create_notification
  get 'checkout/create' => 'checkout#create', as: :create

  # Index principal do sistema
  root 'home#index'
  get 'dashboard/index' => 'dashboard#index', as: :index

  # Painel administrativo
  get 'dashboard/admininstrator' => 'dashboard#admininstrator', as: :admininstrator

  # Rotas para sessions e registrations passando pela views geradas do devise
  devise_for :users, :controllers  => {
             :registrations => 'users/registrations',
             :sessions => 'users/sessions',
             :passwords => 'users/passwords'
  }

  resources :users
  # Demais modelos
  resources :courses
end
