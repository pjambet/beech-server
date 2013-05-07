module Filterable
  extend ActiveSupport::Concern

  included do
    scope :after, ->(date) do
      build_date_condition('>', date) if date.to_i > 0
    end

    scope :before, ->(date) do
      build_date_condition('<', date) if date.to_i > 0
    end

    class << self
      def build_date_condition(direction, date)
        date = Time.at(date.to_i).utc
        where("date_trunc('second', created_at) #{direction} ?", date)
      end
    end
  end

end
