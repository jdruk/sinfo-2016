Rails.application.routes.draw do
  get 'dashboard/index'

  get 'dashboard/admininstrator'

  devise_for :users
  resources :courses

  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
end
