class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id, :null => false
      t.integer :item_id, :null => false

      t.timestamps
    end

    add_index :likes, :user_id
    add_index :likes, :item_id
  end
end
