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
  include BeechServer::Eventable
  attr_accessible :user_id, :beer_id, :user, :beer

  belongs_to :user
  belongs_to :beer

  has_many :events, as: :eventable

  delegate :name, to: :beer

  validates :beer, presence: true
  validates :user, presence: true

  acts_as_eventable

  default_scope -> { includes :user, :beer }
  scope :for_users, ->(users = []) do
    where('user_id IN (?)', users.map(&:id)).order('created_at DESC')
  end

  scope :after, ->(date) do
    date = Time.at(date.to_i).utc if date.to_i > 0
    where("date_trunc('second', created_at) > ?", date)
  end

end
