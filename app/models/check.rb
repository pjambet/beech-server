# == Schema Information
#
# Table name: checks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  beer_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lat        :float
#  lng        :float
#

class Check < ActiveRecord::Base
  include Eventable
  attr_accessible :user_id, :beer_id, :user, :beer, :lat, :lng

  belongs_to :user
  belongs_to :beer

  delegate :name, to: :beer

  validates :beer, presence: true
  validates :user, presence: true

  default_scope -> { includes(:user, :beer) }

  scope :ordered, -> { includes(:user, :beer).order('checks.created_at DESC') }

  after_create :check_if_user_earned_new_badges

  def check_if_user_earned_new_badges
    user.unearned_badges.each do |badge|
      if user.deserves_badge?(badge)
        user.awards.create(badge: badge)
      end
    end
  end

end

