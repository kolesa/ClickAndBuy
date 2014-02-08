class AddIsBlockedToShop < ActiveRecord::Migration
  def change
    add_column :shops, :blocked, :boolean
  end
end
