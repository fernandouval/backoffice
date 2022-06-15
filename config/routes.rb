Rails.application.routes.draw do
  default_url_options :host => "clientes.fuval.uy"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "admin/dashboard#index"
end
