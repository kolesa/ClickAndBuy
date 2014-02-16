class AddCodeIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :code_id, :integer
  end
end
