module Commentable

  extend ActiveSupport::Concern

  included do
    has_many :comments
    has_many :commenters, through: :comments, source: :user
  end
end

