class Item < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "600x600>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
  
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates :name, presence: true
end
