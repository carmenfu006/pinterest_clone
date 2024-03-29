Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  # get '/about', to: 'pages#about'

  devise_for :users

  resources :users do
    get 'board'
  end

  resources :boards
  resources :pins do
    resources :comments do
      post 'like'
      delete 'unlike'
    end
  end
  resources :likes
end
