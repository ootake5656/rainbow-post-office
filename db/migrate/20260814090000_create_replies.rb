class CreateReplies < ActiveRecord::Migration[7.2]
  def change
    create_table :replies do |t|
      t.references :letter, null: false, foreign_key: true, index: { unique: true }
      t.text :content, null: false

      t.timestamps
    end
  end
end
