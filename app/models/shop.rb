# == Schema Information
#
# Table name: shops
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  desc                :text
#  url                 :string(255)
#  fb                  :string(255)
#  vk                  :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Shop < ActiveRecord::Base
  has_many :items

  has_attached_file :avatar, :styles => { :medium => "600x600>", :thumb => "200x200>" },
    :default_url => "/images/:style/missing.png",
    :storage => :s3,
    :bucket => 'clickandbuy',
    :s3_credentials => {
      :bucket => 'clickandbuy',
      :access_key_id => 'AKIAJHNEN7RZNC2VG3LA',
      :secret_access_key => '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',
    },
    :url => "/:image/:id/:style/:basename.:extension",
    :path => ":image/:id/:style/:basename.:extension"

  validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates :name, presence: true
end
