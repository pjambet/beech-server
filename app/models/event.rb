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
  include BeechServer::Pageable

  attr_accessible :eventable, :user

  belongs_to :eventable, polymorphic: true
  belongs_to :user

  acts_as_pageable

  default_scope -> { includes(:eventable).order('created_at DESC') }

  scope :for_users, ->(users = []) do
    where('user_id IN (?)', users.map(&:id))
  end

  scope :after, ->(date) do
    date = Time.at(date.to_i).utc if date.to_i > 0
    where("date_trunc('second', created_at) > ?", date)
  end

end
