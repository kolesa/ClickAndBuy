class AddVotesToUser < ActiveRecord::Migration
  def change
    add_column :users, :votes, :integer, :defaulf => 5
  end
end
