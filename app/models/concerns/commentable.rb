module Commentable

  extend ActiveSupport::Concern

  included do
    has_many :comments
    has_many :commenters, through: :comments
  end
end

