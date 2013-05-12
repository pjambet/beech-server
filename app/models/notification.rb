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
  belongs_to :user
  belongs_to :notificable, polymorphic: true

  def notify(user, object)
    Notification.create(user: user, notificable: object)
  end
end
