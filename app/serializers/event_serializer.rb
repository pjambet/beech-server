class EventSerializer < ActiveModel::Serializer
  include Serializable
  embed :ids, include: true

  attributes :id
  has_one :eventable, polymorphic: true
  has_one :user
  has_many :comments
  has_many :likes

end
