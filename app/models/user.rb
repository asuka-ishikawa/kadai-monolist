class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  # 暗号化の記述　has_secure_password + Gemfile///gem 'bcrypt', '~> 3.1.7' を有効にしてbundle install
  # Gemfile内で has_secure_password などで検索かければ探せる
end
