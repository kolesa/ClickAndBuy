class AddDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :date, :date
    add_column :users, :gender, :boolean
    add_column :users, :country, :string
    add_column :users, :vk, :string
    add_column :users, :fb, :string
    add_column :users, :tw, :string
    add_column :users, :od, :string
  end
end
