# == Schema Information
#
# Table name: discounts
#
#  id         :integer          not null, primary key
#  discount   :integer
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  likes      :integer
#

class Discount < ActiveRecord::Base
  has_many :items
end
