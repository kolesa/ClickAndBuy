class AddUniqueIndexToDiscounts < ActiveRecord::Migration
  def change
    add_index :discounts, [:item_id, :discount], unique: true
  end
end
