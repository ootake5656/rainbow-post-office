class LettersController < ApplicationController
  before_action :require_login        # 先にログイン状態を確認、未ログインなら移動

  def new
    @pet = current_user.pets.first
    return redirect_to new_pet_path, alert: "先にペット名を登録してください" unless @pet
    # Petが登録されていない場合は手紙の宛先が存在しないのでペット名入力画面に移動

    @letter = draft_letter_for(@pet)
  end

  def confirm
    @pet = current_user.pets.first
    return redirect_to new_pet_path, alert: "先にペット名を登録してください" unless @pet

    @letter = draft_letter_for(@pet)
    @letter.assign_attributes(letter_params)

    if @letter.save(context: :confirmation)
      redirect_to confirmation_letters_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirmation
    @pet = current_user.pets.first
    return redirect_to new_pet_path, alert: "先にペット名を登録してください" unless @pet

    @letter = @pet.letters.where(status: "draft").order(updated_at: :desc).first
    redirect_to new_letter_path, alert: "確認する手紙がありません" unless @letter
  end

  def send_letter
    @pet = current_user.pets.first
    return redirect_to new_pet_path, alert: "先にペット名を登録してください" unless @pet

    @letter = @pet.letters.where(status: "draft").order(updated_at: :desc).first
    return redirect_to new_letter_path, alert: "送信する手紙がありません" unless @letter

    ActiveRecord::Base.transaction do
      @letter.status = "sent"
      @letter.sent_at = Time.current
      @letter.save!(context: :confirmation)
      @letter.create_reply!(content: ManagerReplyTemplate.render(pet: @pet))
    end

    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:alert] = "手紙を保存できませんでした"
    render :confirm, status: :unprocessable_entity
  end

  def save_draft
    pet = current_user.pets.first
    return head :not_found unless pet

    letter = draft_letter_for(pet)

    if letter.update(letter_params)
      head :no_content
    else
      render json: { errors: letter.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy_draft
    pet = current_user.pets.first
    return head :not_found unless pet

    pet.letters.where(status: "draft").destroy_all
    head :no_content
  end

  private

  def draft_letter_for(pet)
    pet.letters.where(status: "draft").order(updated_at: :desc).first_or_initialize
  end

  def letter_params
    params.require(:letter).permit(:content)
  end
end
