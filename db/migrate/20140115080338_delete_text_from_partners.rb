class DeleteTextFromPartners < ActiveRecord::Migration
  def change
    rename_column(:partners, :type, :activity)
    remove_column(:partners, :text)
  end
end
