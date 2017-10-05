class RankingsController < ApplicationController
  def want
    @ranking_counts = Want.ranking
    @items = Item.find(@ranking_counts.keys)
    # @ranking_counts = Want.rankingは[item_id => Want の数]
    #     ex.[id_1のアイテムの wantの数(want数多い順)]というハッシュデータが入っている
    # このデータだけではitemsを表示できない
    # @ranking_counts.keysでハッシュから[item_idだけ取り出した配列]を取得
    # @items = Item.find(@ranking_counts.keys) で [item_idだけ取り出した配列]からitemsを取得
    # @itemsはランキング通りの並び順
    # @itemsと@ranking_countsを利用して、ランキングページを作成する
  end
end