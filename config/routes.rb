Rails.application.routes.draw do
  get 'game' => 'games#show', as: :game

  # scope the backend to provide deeplinks for ember-app
  scope '/backend' do

    as :user do
      patch '/users/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
    end
    devise_for :users, controllers: { sessions: 'sessions' }

    resources :users
    resources :roles
    resources :employees
    resources :players
    resources :sections
    resources :contents
    resources :countries, only: [:index, :show]
  end
  mount_ember_app :frontend, to: "/", controller: "application", action: "index"
end
