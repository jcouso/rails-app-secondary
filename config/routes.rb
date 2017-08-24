Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/sysadmin', as: 'rails_admin'
  devise_for :users
  root to: 'securities#index'

  namespace :admin do
    resources :statements, only: [:index]
    resources :securities do
      resources :bids
    end
    get 'mybids', to: 'bids#mybids'
  end

  resources :securities, only: [:index, :show] do
    member do
      post :calculate
    end

    collection do
      get 'search'
      get 'ajax_calculate'
    end
  end

end
