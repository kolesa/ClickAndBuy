# == Schema Information
#
# Table name: counters
#
#  id         :integer          not null, primary key
#  like_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Counter < ActiveRecord::Base
  belongs_to :user
  belongs_to :like
end
