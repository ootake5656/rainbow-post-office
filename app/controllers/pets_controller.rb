class PetsController < ApplicationController
  before_action :redirect_if_pet_registered, only: %i[new create]

  def new
    @pet = Pet.new
  end

  def create
    @pet = current_user.pets.build(pet_params)  # buildによってcurrent_userと紐付ける

    if @pet.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity  # 入力内容に問題があると入力画面を再表示する
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name)
  end

  def redirect_if_pet_registered
   redirect_to root_path if current_user&.pets&.exists?
  end
end