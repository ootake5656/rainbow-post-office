class ChangeLettersUserToPet < ActiveRecord::Migration[7.2]
  def change
    # user_id を削除
    remove_reference :letters, :user, foreign_key: true

    # pet_id を追加
    add_reference :letters, :pet, null: false, foreign_key: true
  end
end
