class AddOwnerCallNameToPets < ActiveRecord::Migration[7.2]
  def change
    add_column :pets, :owner_call_name, :string
  end
end
