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
      redirect_to root_path
    else
      # 入力内容に問題がある場合は入力画面を再表示する
      render :new, status: :unprocessable_entity
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name)
  end

  def redirect_if_pet_registered
    redirect_to root_path if current_user.pets.exists?
  end
end
