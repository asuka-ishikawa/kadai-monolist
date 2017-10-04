class Want < Ownership
# user.itemsだとWANTもHAVEも取得してしまう///typeカラムでWantとHaveを区別する
# user.want_items///WantモデルはOwnershipモデルにtype='Want'となるだけ///継承関係で表現
# $ rails g model Want --parent=Ownership で継承関係を表現したモデルを作成できる
# レコードの保存はownershipsテーブル///新規マイグレーションファイルは不要

# Wantのテーブルは継承元Ownership の保存先テーブルownerships内で
# type名がclass名(Want)と同じWantであるレコードだけをWantクラスのインスタンスとして扱う

end
