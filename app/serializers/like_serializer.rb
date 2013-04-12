class LikeSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id

  has_one :event
  has_one :user
end
