class Event < ActiveRecord::Base
  belongs_to :eventable, polymorphic: true
  belongs_to :user

  attr_accessible :eventable, :user

  default_scope -> { includes :eventable }

  scope :for_users, ->(users = []) do
    where('user_id IN (?)', users.map(&:id))
  end

  scope :after, ->(date) do
    date = Time.at(date.to_i).utc if date.to_i > 0
    where("date_trunc('second', created_at) > ?", date)
  end
end
