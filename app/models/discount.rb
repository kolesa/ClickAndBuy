# == Schema Information
#
# Table name: discounts
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  discount   :integer
#  count      :integer
#  likes      :integer
#  created_at :datetime
#  updated_at :datetime
#

class Discount < ActiveRecord::Base
  has_many :items
end
