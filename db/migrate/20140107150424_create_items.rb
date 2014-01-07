class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :desc
      t.boolean :published
      t.integer :price

      t.timestamps
    end
  end
end
