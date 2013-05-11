module Commenter

  extend ActiveSupport::Concern

  included do
    has_many :comments, dependent: :destroy
    has_many :commented_events, through: :comments, source: :event

    def comment(event, params)
      comment_obj =self.comments.create event: event, content: params['content']
      Notifier.new(comment_obj, self).create_notification
      comment_obj
    end

  end
end

