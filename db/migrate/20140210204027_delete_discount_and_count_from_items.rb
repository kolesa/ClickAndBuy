class DeleteDiscountAndCountFromItems < ActiveRecord::Migration
  def change
    remove_column(:items, :discount)
    remove_column(:items, :count)

    add_column :discounts, :count, :integer, :defaulf => ''
  end
end
