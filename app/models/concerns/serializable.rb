module Serializable

  extend ActiveSupport::Concern

  included do
    attributes :created_at

    define_method :created_at do
      object.created_at.to_i
    end

  end
end

