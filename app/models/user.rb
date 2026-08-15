class User < ApplicationRecord
  authenticates_with_sorcery!         # Sorceryの設定

  has_many :pets, dependent: :destroy
  has_many :letters, through: :pets

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, on: :create  # confirmation: trueをつけることで
  validates :password_confirmation, presence: true, on: :create         # 下の 属性名_confirmation と比較する
  # on: :create は「新しくデータを作成するときだけ」実行する
end
