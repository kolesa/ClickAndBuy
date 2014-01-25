class AddIndexToLikes < ActiveRecord::Migration
  def change
    add_index :likes, [:user_id, :item_id], unique: true
  end
end
