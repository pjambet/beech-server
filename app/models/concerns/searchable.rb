module Searchable
  module Models

    extend ActiveSupport::Concern

    included do
      scope :search_for, ->(query = "") do
        where('lower(name) ILIKE ?', "%#{query.downcase}%")
      end
    end
  end
end

