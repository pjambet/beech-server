# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :boolean
#

class Like < ActiveRecord::Base
  include Filterable

  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true
  validates :user_id, uniqueness: { scope: :event_id }
  validates :event_id, uniqueness: { scope: :user_id }

end
