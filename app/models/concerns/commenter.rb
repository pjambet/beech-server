module Commenter

  extend ActiveSupport::Concern

  included do
    has_many :comments, dependent: :destroy
    has_many :commented_events, through: :comments, source: :event

    def comment(event, params)
      self.comments.create event: event, content: params['content']
    end

  end
end

