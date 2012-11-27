class EventSerializer < ActiveModel::Serializer
  attributes :id
  has_one :eventable, polymorphic: true

  def type
    object.eventable_type.downcase
  end
end
