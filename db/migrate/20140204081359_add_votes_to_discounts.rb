class AddVotesToDiscounts < ActiveRecord::Migration
  def change
    add_column :discounts, :likes, :integer, :defaulf => 0
  end
end
