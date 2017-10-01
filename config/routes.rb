Rails.application.routes.draw do
  root to:'toppages#index'
  # /スラッシュにアクセスした時toppages#indexに飛ぶルーティング
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
end
