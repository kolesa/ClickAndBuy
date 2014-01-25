class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.integer :like_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :counters, :like_id
    add_index :counters, :user_id
    add_index :counters, [:like_id, :user_id], unique: true
  end
end
