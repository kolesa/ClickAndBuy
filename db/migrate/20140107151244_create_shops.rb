class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.text :desc
      t.string :url
      t.string :fb
      t.string :vk

      t.timestamps
    end
  end
end
