# == Schema Information
#
# Table name: checks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  beer_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Check < ActiveRecord::Base
  include Eventable

  belongs_to :user
  belongs_to :beer

  delegate :name, to: :beer

  validates :beer, presence: true
  validates :user, presence: true

  default_scope -> { includes(:beer) }

  scope :ordered, -> { includes(:user).order('checks.created_at DESC') }

end

