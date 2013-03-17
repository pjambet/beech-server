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
  include Pageable
  include Filterable

  attr_accessible :eventable, :user

  belongs_to :eventable, polymorphic: true
  belongs_to :user

  validates :eventable, presence: true

  acts_as_pageable

  default_scope -> { includes(:eventable).order('created_at DESC') }

  delegate :user, to: :eventable, prefix: false

  scope :for_users, ->(users) do
    return [] unless Enumerable === users
    where('user_id IN (?)', users.map(&:id))
  end

end
