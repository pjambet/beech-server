class CommentSerializer < ActiveModel::Serializer
  include Serializable

  embed :ids, include: true
  attributes :id, :content

  has_one :event
  has_one :user
end

