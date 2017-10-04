class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  # アクションではないメソッドはprivateとするのが基本
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
    
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
  # def read(result)は少し複雑な検索結果から、必要な値を読みだして、最後に配列としてreturnしているだけ
  # 画像サイズ128は小さすぎる 無理やり元画像を取得している
  # gsub///文字置換用メソッド 第一引数を見つけだして第二引数に置換する。この場合カラ文字＝削除する
  # gsub///groupsubの略称
  # この場合指定されたサイズが小さすぎるので、サイズ指定を削除して元の画像サイズで取得している
  # "mediumImageUrls"=>[{"imageUrl"=>"http://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6295/9784797386295.jpg?_ex=128x128"}]
end
