# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  include Filterable
  include Notificable

  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true
  validates :content, presence: true

  attr_accessible :content, :event

end
