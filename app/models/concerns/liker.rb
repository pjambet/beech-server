module Liker

  extend ActiveSupport::Concern

  included do
    has_many :likes, dependent: :destroy
    has_many :liked_events, through: :likes, source: :event

    def like(event)
      like_obj = self.likes.create! event: event
      Notifier.new(like_obj, event.user).create_notification
      like_obj
    end

    def unlike(event)
      self.liked_events.delete(event)
    end

    def like?(event, events: self.liked_events.to_a)
      return false if events.nil?
      events.include? event
    end
  end
end
