class CreateOwnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t|
      t.string :type
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :item_id, :type], unique: true
      # :type には WANT HAVE が入る同一ユーザが同一アイテムに対して複数回want/haveできないようにする制約
    end
  end
end
