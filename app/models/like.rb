# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true

  attr_accessible :user, :event
end
