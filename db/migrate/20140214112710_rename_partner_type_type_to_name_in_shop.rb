class RenamePartnerTypeTypeToNameInShop < ActiveRecord::Migration
  def change
    rename_column(:shops, :type, :p_type)
  end
end
