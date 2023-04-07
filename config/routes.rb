Rails.application.routes.draw do

  root to: "homes#top"
  get '/home/top' => "homes#top", as: "top"
  get "/home/about" => "homes#about",as: "about"
  devise_for :users
  resources :books, only:[:new, :index, :show, :create, :update, :edit, :destroy]
  resources :users, only:[:show, :edit, :index, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
