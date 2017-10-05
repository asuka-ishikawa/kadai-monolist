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
        item = Item.find_or_initialize_by(read(result))
          # 扱い易いように Item としてインスタンスを作成する
          # item = Item.new(read(result))で全てを保存していないインスタンスにするのではなく
          # すでに保存されているItemに関してはitem.idの値も含めたいので.find_or_initialize_by
          # item.idはフォームからUnwantするときに使用する
        @items << item
          # @items << item でitemを[]に追加していく
      end
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @have_users = @item.have_users
  end
end
