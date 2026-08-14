class LettersController < ApplicationController
  before_action :require_login        # 先にログイン状態を確認、未ログインなら移動

  def new
    @pet = current_user.pets.first
    return redirect_to new_pet_path, alert: "先にペット名を登録してください" unless @pet
    # Petが登録されていない場合は手紙の宛先が存在しないのでペット名入力画面に移動

    @letter = @pet.letters.build
  end
end
