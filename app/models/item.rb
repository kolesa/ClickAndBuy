class Item < ActiveRecord::Base
  
  belongs_to :shop
  has_many :users, :through => :likes
  
  has_attached_file :avatar, :styles => { :medium => "600x600>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
  
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates :name, presence: true

  acts_as_taggable
  #acts_as_taggable_on :category
end
