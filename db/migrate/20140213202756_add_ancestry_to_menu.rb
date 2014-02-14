class AddAncestryToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :ancestry, :string
  end
end
