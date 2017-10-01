Rails.application.routes.draw do
  root to:'toppages#index'
  # /スラッシュにアクセスした時toppages#indexに飛ぶルーティング
end
