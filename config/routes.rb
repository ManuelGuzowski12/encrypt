Rails.application.routes.draw do
  root 'messages#index'
  get 'messages' => 'messages#index'
  get 'messages/new' => 'messages#new'
  get 'messages/:id' => 'messages#show'
  post 'messages' => 'messages#create'
  get 'error' => 'decrypt#index'
  post 'decrypt' => 'decrypt#show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'signup'  => 'users#new'
  resources :users
end
