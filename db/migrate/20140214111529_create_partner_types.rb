class CreatePartnerTypes < ActiveRecord::Migration
  def change
    create_table :partner_types do |t|
      t.string :type

      t.timestamps
    end
  end
end
