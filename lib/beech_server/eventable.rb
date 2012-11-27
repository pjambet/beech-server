module BeechServer
  module Eventable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_eventable
        has_one :event, as: :eventable

        after_create do
          create_event eventable: self, user: user
        end
      end
    end
  end
end
