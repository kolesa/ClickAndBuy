class AddEndDateToItems < ActiveRecord::Migration
  def change
    add_column :items, :end_date, :date
    add_column :items, :count,    :integer
  end
end
