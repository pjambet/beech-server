module Filterable
  extend ActiveSupport::Concern

  included do
    scope :after, ->(date) do
      if date.to_i > 0
        build_date_condition('>', date)
      end
    end

    scope :before, ->(date) do
      if date.to_i > 0
        build_date_condition('<', date)
      end
    end

    class << self
      def build_date_condition(direction, date)
        date = Time.at(date.to_i).utc
        where("date_trunc('second', created_at) #{direction} ?", date)
      end
    end
  end

end
