# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  is_admin               :boolean          default(FALSE)
#  owned_shop             :integer          default(0)
#  first_name             :string(255)
#  last_name              :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  date                   :date
#  gender                 :boolean
#  country                :string(255)
#  vk                     :string(255)
#  fb                     :string(255)
#  tw                     :string(255)
#  od                     :string(255)
#  is_banned              :boolean          default(FALSE)
#  provider               :string(255)
#  uid                    :string(255)
#  votes                  :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,\
     :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :vkontakte, :twitter,:odnoklassniki]
  
  validates :password, presence: true
  validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true

  has_many :items, :through => :likes
  has_many :likes

  has_many :likes, :through => :counters
  has_many :counters

  has_attached_file :avatar,
    :styles => { :medium => "600x600>", :thumb => "80x80>" },
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

  def self.search(search)
    if search
      where('lower(first_name) LIKE lower(?) OR lower(last_name) LIKE lower(?)', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  
  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider   = auth.provider
        user.uid        = auth.uid
        user.email      = auth.info.email
        user.password   = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name  = auth.info.last_name
        user.avatar     = auth.info.image
        user.country    = auth.info.location
        user.votes      = 5
        user.save!
      end
    end
  end

  def self.find_for_odnoklassniki_oauth(auth)
    p auth.info
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider   = auth.provider
        user.uid        = auth.uid
        user.email      = "#{auth.uid}@odnoklassniki.ru"
        user.password   = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name  = auth.info.last_name
        # it`s so HARD
        user.avatar     = auth.info.image.split('&')[0]
        user.country    = auth.info.location
        user.votes      = 5
        user.save!
      end
    end
  end

  def self.find_for_vkontakte_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider   = auth.provider
        user.uid        = auth.uid
        user.email      = "#{auth.uid}@vk.com"
        user.password   = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name  = auth.info.last_name
        user.avatar     = auth.info.image
        user.country    = auth.info.location
        user.votes      = 5
        user.save!
      end
    end
  end

  def self.find_for_twitter_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      unless user.persisted?
        user.provider   = auth.provider
        user.uid        = auth.uid
        user.email      = "#{auth.info.nickname}@twitter.com"
        user.password   = Devise.friendly_token[0,20]
        user.first_name = auth.info.name
        user.avatar     = auth.info.image
        user.country    = auth.info.location
        user.votes      = 5
        user.save!
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.update_likes
    User.update_all(votes: 5)
  end

end
