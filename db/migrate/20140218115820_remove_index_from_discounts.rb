class RemoveIndexFromDiscounts < ActiveRecord::Migration
  def change
      remove_index "discounts", name: "index_discounts_on_item_id_and_discount"
  end
end
