module BeechServer
  module Eventable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_eventable
        
      end
    end
  end
end
