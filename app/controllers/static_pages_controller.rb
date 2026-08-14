class StaticPagesController < ApplicationController
  def top
    return unless logged_in?

    latest_letter = current_user.letters
      .with_available_reply
      .where(replies: { read_at: nil })
      .order(sent_at: :desc)
      .first
    @available_reply = latest_letter&.reply
  end
end
