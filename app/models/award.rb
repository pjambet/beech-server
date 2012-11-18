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
  include BeechServer::Eventable
  attr_accessible :user_id, :badge_id, :user, :badge

  belongs_to :user
  belongs_to :badge

  has_many :events, as: :eventable

  validates :user, presence: true
  validates :badge, presence: true
  validates :badge_id, uniqueness: { scope: :user_id }
  validates :user_id, uniqueness: { scope: :badge_id }

  acts_as_eventable
end
