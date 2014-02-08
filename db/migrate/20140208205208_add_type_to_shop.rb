class AddTypeToShop < ActiveRecord::Migration
  def change
    add_column :shops, :type, :integer, :defaul => 1
  end
end
