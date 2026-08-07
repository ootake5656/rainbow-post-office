class AddColumnsToLetters < ActiveRecord::Migration[7.2]
  def change
    add_column :letters, :status, :string, default: 'draft', null: false     # 手紙の下書き保存
    add_column :letters, :sent_at, :datetime  # 手紙の送信日時を記録
  end
end
