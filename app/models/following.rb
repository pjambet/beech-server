class Following < ActiveRecord::Base

  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  attr_accessible :follower, :followee, :follower_id, :followee_id

  validates :follower, presence: true
  validates :followee, presence: true
end
