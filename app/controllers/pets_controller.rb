class PetsController < ApplicationController
  before_action :require_login
  before_action :redirect_if_pet_registered, only: %i[new create]

  def new
    @pet = Pet.new
  end

  def create
    # buildによってログイン中のユーザーとPetを紐付ける
    @pet = current_user.pets.build(pet_params)

    if @pet.save
      redirect_to owner_call_name_pets_path
    else
      # 入力内容に問題がある場合は入力画面を再表示する
      render :new, status: :unprocessable_entity
    end
  end

  # ユーザーの呼び名を入力
  def owner_call_name
    @pet = current_user.pets.first
    redirect_to new_pet_path, alert: "先にペット名を登録してください" unless @pet
  end

  def update_owner_call_name
    @pet = current_user.pets.first
    return redirect_to new_pet_path, alert: "先にペット名を登録してください" unless @pet

    if @pet.update(owner_call_name_params)
      redirect_to new_letter_path
    else
      render :owner_call_name, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name)
  end

  def owner_call_name_params
    params.require(:pet).permit(:owner_call_name)
  end

  def redirect_if_pet_registered
    redirect_to root_path if current_user.pets.exists?
  end
end
