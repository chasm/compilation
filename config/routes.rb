Compilation::Application.routes.draw do
  
  get "reset/:code" => "password#edit", as: :reset
  put "reset/:code" => "password#update"
  
  get "login" => "session#new"
  post "login" => "session#create"
  delete "logout" => "session#destroy"
  get "logout" => "session#destroy"
  
  get "register" => "users#new", as: :register
  
  resources :users
  
  root 'songs#index'
end
