class AddParentIdToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :parent_id, :integer
    add_index :microposts, :parent_id
  end
end
