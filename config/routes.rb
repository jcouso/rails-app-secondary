Rails.application.routes.draw do
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
    collection do
      get 'search', to: 'securities#search'
    end
  end

end
