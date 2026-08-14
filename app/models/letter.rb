class Letter < ApplicationRecord
  belongs_to :pet
  has_one :reply, dependent: :destroy

  validates :content, presence: true, on: :confirmation
end
