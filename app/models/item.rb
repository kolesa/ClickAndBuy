# == Schema Information
#
# Table name: items
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  desc                :text
#  published           :boolean
#  price               :integer
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  shop_id             :integer
#  end_date            :date
#

class Item < ActiveRecord::Base
  
  belongs_to :shop
  has_many :users, :through => :likes
  has_many :likes

  has_many :discounts, :dependent => :destroy 
  accepts_nested_attributes_for :discounts

  
  has_attached_file :avatar, :styles => { :medium => "x300", :thumb => "200x200>" },
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
    
  #validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates :name, presence: true
  validates :end_date, presence: true
  validates :price, presence: true

  acts_as_taggable
  #acts_as_taggable_on :category

  def self.search(search)
    if search
      where('lower(name) LIKE lower(?)', "%#{search}%")
    else
      scoped
    end
  end

end
