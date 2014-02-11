class AddActiveToDiscounts < ActiveRecord::Migration
  def change
    add_column :discounts, :active, :boolean
  end
end
