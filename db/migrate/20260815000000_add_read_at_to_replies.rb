class AddReadAtToReplies < ActiveRecord::Migration[7.2]
  def change
    add_column :replies, :read_at, :datetime
  end
end
