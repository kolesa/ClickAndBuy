class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.text :company
      t.string :type
      t.string :text
      t.text :name
      t.text :phone
      t.text :email
      t.text :url

      t.timestamps
    end
  end
end
