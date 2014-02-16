# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  ancestry   :string(255)
#  position   :string(255)
#

class Menu < ActiveRecord::Base
  has_ancestry
end
