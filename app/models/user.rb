class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  # 暗号化の記述　has_secure_password + Gemfile///gem 'bcrypt', '~> 3.1.7' を有効にしてbundle install
  # Gemfile内で has_secure_password などで検索かければ探せる
  
  has_many :ownerships
  has_many :items, through: :ownerships
  # user.ownerships///中間テーブルのインスタンス群を取得可能
  # user.items///userがwant/haveしているitems を取得可能
  
  has_many :wants
  has_many :want_items, through: :wants, class_name: 'Item', source: :item
  # user.want_items でWantしたItemだけを取得できるようにしている///継承されたモデルWantから
  
  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
    # item_idカラムから、渡されたitem.idを探す なければ作る
  end
  
  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end
  
  def want?(item)
    self.want_items.include?(item)
  end
end
