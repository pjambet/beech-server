module Searchable
  module Models
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def searchable_by(column_name)
        scope :search_for, ->(query = '') do
          where("lower(#{column_name}) ILIKE ?", "%#{query.downcase}%")
        end
      end
    end
  end
end

