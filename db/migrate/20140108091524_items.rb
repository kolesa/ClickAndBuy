class Items < ActiveRecord::Migration
  def change
    change_table :items do |t|
      t.belongs_to :shop
    end
  end
end
