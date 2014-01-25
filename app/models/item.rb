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
#  discount            :integer
#  shop_id             :integer
#

class Item < ActiveRecord::Base
  
  belongs_to :shop
  has_many :users, :through => :likes
  has_many :likes
  
  has_attached_file :avatar, :styles => { :medium => "600x600>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
  
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates :name, presence: true

  acts_as_taggable
  #acts_as_taggable_on :category
end
