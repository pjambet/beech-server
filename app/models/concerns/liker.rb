module Liker

  extend ActiveSupport::Concern

  included do
    has_many :likes, dependent: :destroy
    has_many :liked_events, through: :likes, uniq: true, source: :event

    def like(event)
      self.likes.create event: event
    end

    def unlike(event)
      self.liked_events.delete(event)
    end
  end
end
