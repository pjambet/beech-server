class EventSerializer < ActiveModel::Serializer
  include Serializable

  attributes :id
  has_one :eventable, polymorphic: true
  has_one :user

end
