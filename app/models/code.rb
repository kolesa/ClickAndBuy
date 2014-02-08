# == Schema Information
#
# Table name: codes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  item_id    :integer
#  discount   :integer
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Code < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
end
