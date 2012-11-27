class EventSerializer < ActiveModel::Serializer
  include BeechServer::Serializable

  attributes :id
  serialized_with_timestamp
  has_one :eventable, polymorphic: true
  has_one :user

end
