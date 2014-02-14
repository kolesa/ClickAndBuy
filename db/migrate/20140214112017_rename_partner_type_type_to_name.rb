class RenamePartnerTypeTypeToName < ActiveRecord::Migration
  def change
    rename_column(:partner_types, :type, :name)
  end
end
