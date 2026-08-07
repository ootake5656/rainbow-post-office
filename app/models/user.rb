class User < ApplicationRecord
  authenticates_with_sorcery!         # Sorceryの設定

  has_many :pets, dependent: :destroy
  has_many :letters, through: :pets
end
