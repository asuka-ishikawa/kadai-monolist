Rails.application.routes.draw do
  root to: 'toppages#index'
  # /スラッシュにアクセスした時toppages#indexに飛ぶルーティング
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  resources :items, only: [:new]
  # 楽天APIを使った検索結果を表示するページ(new)のみ
  # 検索したもの全てを保存する必要はない(だからnewのみ)
  # 共有したいものだけを保存する///Want,Have機能の実装時にItemを保存する
end
