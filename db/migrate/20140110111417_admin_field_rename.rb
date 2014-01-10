class AdminFieldRename < ActiveRecord::Migration
  def change
    rename_column(:users, :firs_name, :first_name)
  end
end
