class AddOrderToTag < ActiveRecord::Migration
  def change
    add_column :tags, :order, :integer, :default => 0
  end
end
