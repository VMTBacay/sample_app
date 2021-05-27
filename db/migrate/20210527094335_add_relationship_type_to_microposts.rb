class AddRelationshipTypeToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :relationship_type, :integer
  end
end
