class CreateReposts < ActiveRecord::Migration[6.1]
  def change
    create_table :reposts do |t|
      t.integer :micropost_id
      t.integer :user_id

      t.timestamps
    end
    add_index :reposts, :micropost_id
    add_index :reposts, :user_id
    add_index :reposts, [:micropost_id, :user_id], unique: true
  end
end