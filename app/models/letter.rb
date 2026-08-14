class Letter < ApplicationRecord
  belongs_to :pet
  has_one :reply, dependent: :destroy

  scope :with_available_reply, lambda {
    joins(:reply)
      .where(sent_at: ..(Time.current - Rails.application.config.x.reply_wait_time))
  }

  validates :content, presence: true, on: :confirmation

  def reply_available_at
    return unless sent_at

    sent_at + Rails.application.config.x.reply_wait_time
  end

  def reply_available?
    return false unless reply && reply_available_at

    Time.current >= reply_available_at
  end
end
