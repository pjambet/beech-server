# == Schema Information
#
# Table name: awards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  badge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Award < ActiveRecord::Base
  attr_accessible :user_id, :badge_id

  belongs_to :user
  belongs_to :badge
end
