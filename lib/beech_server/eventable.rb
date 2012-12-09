module BeechServer
  module Eventable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_eventable(opts = {})
        opts[:required] ||= true
        has_one :event, as: :eventable, dependent: :destroy
        if opts.delete(:required)
          validates :event, presence: true, if: :persisted?
        end
        after_create do
          create_event eventable: self, user: user
        end
      end
    end
  end
end

