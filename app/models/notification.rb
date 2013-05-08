# == Schema Information
#
# Table name: notifications
#
#  id               :integer          not null, primary key
#  notificable_type :string(255)
#  notificable_id   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :notificable

  belongs_to :notificable, polymorphic: true
end
