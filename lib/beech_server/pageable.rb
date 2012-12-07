module BeechServer
  module Pageable

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_pageable(opts = {})
        scope :paginate, ->(page = 1, opts = {}) do
          limit(per_page).offset((page - 1) * per_page )
        end

        def per_page
          20
        end
      end
    end
  end
end

