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
  include Eventable

  belongs_to :user
  belongs_to :badge

  validates :user, presence: true
  validates :badge, presence: true

  default_scope -> { includes(:badge) }

  delegate :name, to: :badge

end

