# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.create(
  email: 'admin@click.ru',
  password: 'qweasdzxc',
  password_confirmation: 'qweasdzxc',
  is_admin: 1
)

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