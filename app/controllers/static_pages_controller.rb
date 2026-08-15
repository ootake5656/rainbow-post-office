class StaticPagesController < ApplicationController
  before_action :require_login, only: :diary_coming_soon

  def top
    return unless logged_in?

    latest_letter = current_user.letters
      .with_available_reply
      .where(replies: { read_at: nil })
      .order(sent_at: :desc)
      .first
    @available_reply = latest_letter&.reply
  end

  def diary_coming_soon; end
end
