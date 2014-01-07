class AddAttachmentAvatarToShops < ActiveRecord::Migration
  def self.up
    change_table :shops do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :shops, :avatar
  end
end
