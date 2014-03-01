class SetDefaultVotesToFiveInUsers < ActiveRecord::Migration
  def change
    change_column_default(:users, :votes, 5)
  end
end
