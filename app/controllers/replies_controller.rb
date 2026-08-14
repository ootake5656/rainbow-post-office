class RepliesController < ApplicationController
  before_action :require_login

  def show
    @reply = Reply.joins(letter: :pet)
      .find_by(id: params[:id], pets: { user_id: current_user.id })
    return redirect_to root_path, alert: "お返事が見つかりません" unless @reply

    @letter = @reply.letter
    return redirect_to root_path, alert: "お返事はまだ届いていません" unless @letter.reply_available?

    @pet = @letter.pet
  end
end
