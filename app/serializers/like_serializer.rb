class LikeSerializer < ActiveModel::Serializer
  include Serializable

  embed :ids, include: true
  attributes :id

  has_one :event, embed: :ids, include: false
  has_one :user
end
