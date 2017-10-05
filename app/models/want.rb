class Want < Ownership
# user.itemsだとWANTもHAVEも取得してしまう///typeカラムでWantとHaveを区別する
# user.want_items///WantモデルはOwnershipモデルにtype='Want'となるだけ///継承関係で表現
# $ rails g model Want --parent=Ownership で継承関係を表現したモデルを作成できる
# レコードの保存はownershipsテーブル///新規マイグレーションファイルは不要

# Wantのテーブルは継承元Ownership の保存先テーブルownerships内で
# type名がclass名(Want)と同じWantであるレコードだけをWantクラスのインスタンスとして扱う

  def self.ranking
    self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
  end
  # クラスメソッド：誰が見ても、同じ結果になるもの/インスタンスが必要ないもの
  # 'count_item_id DESC'///wantのカウントが多い順にならべる
  # .group(:item_id)はレコードをitem_idカラムでグループ化している
  # .count(:item_id)でグループ化させたitem_idの数をカウント
  # count_item_idは.count(:item_id)をするために一時的なカウントカラム
  # .limit(10)　ランキングに表示する数
end
