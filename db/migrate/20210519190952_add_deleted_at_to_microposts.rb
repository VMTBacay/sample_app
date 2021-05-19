class AddDeletedAtToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :deleted_at, :datetime
    add_index :microposts, :deleted_at
  end
end
