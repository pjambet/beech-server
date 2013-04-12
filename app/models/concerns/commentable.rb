module Commentable

  extend ActiveSupport::Concern

  included do
    has_many :comments
    has_many :commenters, through: :comments, uniq: true, class_name: 'User'
  end
end

