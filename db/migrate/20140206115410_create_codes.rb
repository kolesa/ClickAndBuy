class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :discount
      t.string :code

      t.timestamps
    end
  end
end
