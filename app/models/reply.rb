class Reply < ApplicationRecord
  belongs_to :letter

  validates :content, presence: true
end
