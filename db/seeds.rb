# Admin

admin = User.create(
  email: 'admin@click.ru',
  password: 'qweasdzxc',
  password_confirmation: 'qweasdzxc',
  is_admin: 1
)

# Users
10.times do |user|
  user = User.create(
    email:      Faker::Internet.safe_email,
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    country:    Faker::Address.country,
    gender:     rand(2) > 0.5 ? 1 : 0,
    vk:         Faker::Internet.url,
    fb:         Faker::Internet.url,
    tw:         Faker::Internet.url,
    od:         Faker::Internet.url,
    password:              '123456789',
    password_confirmation: '123456789',
  )  
end

# Shop
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
Shop.create(
  name:       Faker::Company.name,
  desc:       Faker::Lorem.sentence(30),
  url:       Faker::Internet.url,
  vk:         Faker::Internet.url,
  fb:         Faker::Internet.url,
  avatar: File.open("#{Rails.root}/app/assets/images/seed/shop.png")
  )

# Items
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
for file in 1..6 do
  Item.create(
    shop_id:    Shop.first.id,
    name:       Faker::Commerce.product_name,
    desc:       Faker::Lorem.sentence(20),
    published:  true,
    price:      Faker::Number.number(3),
    discount:   Faker::Number.digit,
    avatar: File.open("#{Rails.root}/app/assets/images/seed/#{file}.jpg")
  )  
end


# Partners
  #  id         :integer          not null, primary key
  #  company    :text
  #  activity   :string(255)
  #  name       :text
  #  phone      :text
  #  email      :text
  #  url        :text
  #  created_at :datetime
  #  updated_at :datetime
  #
10.times do |partnet|
  partnet = Partner.create(
    company:   Faker::Company.name,
    activity:  Faker::Commerce.department,
    name:      Faker::Name.name,
    phone:     Faker::PhoneNumber.phone_number,
    email:     Faker::Internet.email,
    url:       Faker::Internet.url,
  )  
end

