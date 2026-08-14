class Pet < ApplicationRecord
  belongs_to :user
  has_many :letters, dependent: :destroy

  validates :name, presence: true
  validates :user_id, uniqueness: true
  validates :owner_call_name, presence: true, on: :update
end
