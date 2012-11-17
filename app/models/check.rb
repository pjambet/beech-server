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
  attr_accessible :user_id, :beer_id

  belongs_to :user
  belongs_to :beer

  delegate :name, to: :beer

  validates :beer, presence: true
  validates :user, presence: true
  validates :beer_id, uniqueness: { scope: :user_id }
  validates :user_id, uniqueness: { scope: :beer_id }
end
