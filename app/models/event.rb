# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  eventable_id   :integer
#  user_id        :integer
#  eventable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Event < ActiveRecord::Base
  include Filterable
  include Likeable
  include Commentable

  belongs_to :eventable, polymorphic: true
  belongs_to :user

  validates :eventable, presence: true

  default_scope -> { order('events.created_at DESC') }

  # This triggers n+1 queries, until I find a way to remove the user from here
  # this will stay commented
  # delegate :user, to: :eventable, prefix: false

  scope :for_users, ->(users) do
    return [] unless Enumerable === users
    where('user_id IN (?)', users.map(&:id))
  end

  def details
    eventable.name
  end

end
