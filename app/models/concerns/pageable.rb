module Pageable

  extend ActiveSupport::Concern

  module ClassMethods
    def acts_as_pageable(opts = {})
      scope :paginate, ->(page, opts = {}) do
        page = (page.nil? || page.to_i <= 0 ) ? 1 : page
        limit(per_page).offset((page.to_i - 1) * per_page )
      end

      def per_page
        40
      end
    end
  end
end
