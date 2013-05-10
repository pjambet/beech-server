# == Schema Information
#
# Table name: followings
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Following < ActiveRecord::Base
  include Notificable

  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  attr_accessible :follower, :followee, :follower_id, :followee_id

  validates :follower, presence: true
  validates :followee, presence: true
end
