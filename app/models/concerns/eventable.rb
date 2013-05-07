module Eventable

  extend ActiveSupport::Concern

  included do
    has_one :event, as: :eventable, dependent: :destroy

    validates :event, presence: true, if: :persisted?

    after_create do
      create_event eventable: self, user: user
    end
  end
end

