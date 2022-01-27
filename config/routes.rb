Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "courses#new"
  get "courses/new" , to: "courses#new"
  get "index", to: "courses#index"
  post "courses/new", to: "courses#create"
end
