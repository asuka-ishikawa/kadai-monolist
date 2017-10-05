Rails.application.routes.draw do
  root to: 'toppages#index'
  # /スラッシュにアクセスした時toppages#indexに飛ぶルーティング
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  resources :items, only: [:show, :new]
  resources :ownerships, only: [:create, :destroy]
  # (new)楽天APIを使った検索結果を表示するページ///検索したもの全てを保存する必要はない
  # (show)共有したいものだけを保存する///Want,Have機能の実装時にItemを保存する
  # resources :ownerships, only: [:create, :destroy]
  # ownerships///中間テーブル
  
  get 'rankings/want', to: 'rankings#want'
  get 'rankings/have', to: 'rankings#have'
end
