class AddParentToTag < ActiveRecord::Migration
  def change
    add_column :tags, :parent, :integer, :default => 0
  end
end
