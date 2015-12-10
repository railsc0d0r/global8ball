Rails.application.routes.draw do
  # scope the backend to provide deeplinks for ember-app
  scope '/backend' do
    devise_for :users, controllers: { sessions: 'sessions' }
    resources :users
    resources :employees
    resources :players
  end
  mount_ember_app :frontend, to: "/", controller: "application", action: "index"
end
