class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      #t.integer :item_id
      t.integer :discount
      t.belongs_to :item
      t.timestamps
    end
  end
end
