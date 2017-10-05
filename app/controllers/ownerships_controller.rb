class OwnershipsController < ApplicationController
# ItemのWantボタンが押されたらこのアクションに行き着く。このタイミングでItemを保存する
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])
      # 探してみつかれば,保存されていたインスタンスを返す///みつからなければItem.new新規作成
      # wantボタンは１つのアイテムに対して行うアクションである なので、単数形
    
    unless @item.persisted?
        # @item.persisted?///取得したインスタンス@itemすでに保存されているか判断する
        # unless @item.persisted?///保存されていなければtrue ＝ ブロック内の処理を実行(保存する)
        # @item が保存されていない場合、先に @item を保存する
        # ///persisted 残存する
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
        # itemCode(楽天市場商品のid)で楽天市場を検索する///要素１つの配列として返ってくるので
        # result.firstで唯一の要素を取得
        # readはあとでapplication_controller.rbへ移動する前提で使用している
        # items_controller.rb/read(result.first)のreadはそのままだと使えないため
      @item = Item.new(read(results.first))
      @item.save
    end
    
    # Want 関係として保存
    if params[:type] == 'Want'
        # HAVE と区別するため
        # params[:type]はフォームを作成するときに設定する
      current_user.want(@item)
        # current_user///helperで定義
        # wantメソッドは @item.id を必要とする。なければスルーしてしまう
        # unless @item.persisted? のブロックで保存は完了している
      flash[:success] = '商品を Want しました。'
    elsif params[:type] =='Have'
      current_user.have(@item)
      flash[:success] = '商品を Have しました。'
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = '商品の Want を解除しました。'
    elsif params[:type] =='Have'
      current_user.unhave(@item)
      flash[:success] = '商品の Have を解除しました。'
    end
    
    redirect_back(fallback_location: root_path)
  end
end