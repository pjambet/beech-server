module Pageable

  extend ActiveSupport::Concern

  module ClassMethods
    def acts_as_pageable(opts = {})
      scope :paginate, ->(page, opts = {}) do
        page ||= 1
        limit(per_page).offset((page.to_i - 1) * per_page )
      end

      def per_page
        20
      end
    end
  end
end
