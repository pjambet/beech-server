class EventSerializer < ActiveModel::Serializer
  attributes :id
  has_one :eventable, polymorphic: true
end
