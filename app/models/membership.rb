# == Schema Information
#
# Table name: memberships
#
#  id      :integer          not null, primary key
#  role_id :integer          not null
#  user_id :integer          not null
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  validates :user, :role, presence: true
end

