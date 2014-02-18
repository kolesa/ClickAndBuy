# Admin
# AKIAJHNEN7RZNC2VG3LA
# JWELknr9Lis57YQn55kCsT6fr1E44MxutO+Jo/fK

include ActionView::Helpers::AssetTagHelper

User.delete_all
Item.delete_all
Shop.delete_all
Discount.delete_all
Like.delete_all
Counter.delete_all
Code.delete_all


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

Shop.create(
  name:       Faker::Company.name,
  desc:       Faker::Lorem.sentence(30),
  url:        Faker::Internet.url,
  vk:         Faker::Internet.url,
  fb:         Faker::Internet.url,
  avatar:     File.open([Rails.root, '/app/assets', image_path("seed/shop.png")].join)
  )

for file in 1..6 do
  Item.create(
    shop_id:    Shop.first.id,
    name:       Faker::Commerce.product_name,
    desc:       Faker::Lorem.sentence(20),
    published:  true,
    price:      Faker::Number.number(3),
    avatar: File.open([Rails.root, '/app/assets', image_path("seed/#{file}.jpg")].join)
  )  
end

Item.where(id: [1..600]).each do |item|
  for i in 1..5 do
    Discount.create(item_id: item.id, discount: (i*5), count: i*5, likes: i*10 , active: true)
  end
end

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