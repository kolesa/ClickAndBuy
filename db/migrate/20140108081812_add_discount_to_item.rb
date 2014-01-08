class AddDiscountToItem < ActiveRecord::Migration
  def change
    add_column :items, :discount, :integer
  end
end
