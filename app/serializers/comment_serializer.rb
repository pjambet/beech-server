class CommentSerializer < ActiveModel::Serializer
  include Serializable

  embed :ids, include: true
  attributes :id, :content

  has_one :event, emded: :ids, include: false
  has_one :user
end

