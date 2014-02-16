# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  item_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  ended      :boolean          default(FALSE)
#

class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  has_many :users, :through => :counters
  has_many :counters
end
