module BeechServer
  module Serializable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def serialized_with_timestamp
        attributes :created_at

        define_method :created_at do
          object.created_at.to_i
        end
      end
    end
  end
end

