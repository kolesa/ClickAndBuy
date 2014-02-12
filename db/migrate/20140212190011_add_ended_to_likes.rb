class AddEndedToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :ended, :boolean, :default => false
  end
end
