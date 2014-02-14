class AddPositionToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :position, :string
  end
end
