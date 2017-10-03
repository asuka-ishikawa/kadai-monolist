class ItemsController < ApplicationController
  before_action :require_user_logged_in
  def new
    @items = []
    # @items をカラの配列として初期化(明示する必要あり)　検索ワードの入力欄だから。
    
    @keyword = params[:keyword]
    # フォームから送信される検索キーワードを取得　viewでtext_field_tag :keyword というinputが設置されるのでこれを受け取る
    if @keyword
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      # フォームから検索ワードが送られるとif内の処理が実行(APIを使用して検索を実行)
      # 検索ワードを設定、画像があるもので20件検索
      
      
      # 上記のresultsからItemモデルのインスタンスを作成
      # インスタンスを使うのはresultを直接扱うより、扱い易いから。
      results.each do |result|
        # 扱い易いように Item としてインスタンスを作成する（保存しない。ここで保存＝検索結果全て保存だから）
        item = Item.new(read(result))
        @items << item
        # @items << item でitemを[]に追加していく
      end
    end
  end
  
  private
  
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
end
