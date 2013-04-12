module Likeable

  extend ActiveSupport::Concern

  included do
    has_many :likes
    has_many :likers, through: :likes, uniq: true, class_name: 'User'
  end
end

