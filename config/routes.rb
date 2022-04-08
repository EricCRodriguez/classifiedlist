Rails.application.routes.draw do
  devise_for :accounts

  resources :posts

  resources :pages
  get "p/:url" => "pages#show", as: :show_page

  resources :categories
  get "c/:url" => "categories#show", as: :show_category

  get "users" => "accounts#index", as: :users
  delete "account/destroy/:id" => "accounts#destroy_account", as: :destroy_account

  post "message/send" => "public#send_enquiry_to_user", as: :send_enquiry

  get "/dashboard" => "accounts#dashboard", as: :dashboard
  get "/admin/dashboard" => "admin#dashboard", as: :admin_dashboard

  post "locale/set" => "languages#set_locale"

  root to: "public#home"
end
