Rails.application.routes.draw do
  devise_for :users
  mount_ember_app :frontend, to: "/", controller: "application", action: "index"
end
