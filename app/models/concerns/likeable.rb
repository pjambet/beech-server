module Likeable

  extend ActiveSupport::Concern

  included do
    has_many :likes
    has_many :likers, through: :likes
  end
end

