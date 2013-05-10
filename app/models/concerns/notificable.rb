module Notificable

  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :notificable

    after_create :create_notification

    def create_notification
      self.notifications.create user: self.user
    end
  end
end

