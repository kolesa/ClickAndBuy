class AddOrderToTagging < ActiveRecord::Migration
  def change
    add_column :taggings, :order, :integer, :default => 0
  end
end
