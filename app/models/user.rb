class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :items, :through => :likes

  has_attached_file :avatar, :styles => { :medium => "600x600>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
  validates_attachment :avatar, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
end
