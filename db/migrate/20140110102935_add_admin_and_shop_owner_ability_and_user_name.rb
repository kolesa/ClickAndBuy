class AddAdminAndShopOwnerAbilityAndUserName < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :owned_shop, :integer, :default => 0
    add_column :users, :firs_name, :string
    add_column :users, :last_name, :string
    add_attachment :users, :avatar
  end
end
