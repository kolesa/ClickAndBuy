class AddParentToTagging < ActiveRecord::Migration
  def change
    add_column :taggings, :parent, :integer, :default => 0
  end
end
