class NotificationSerializer < ActiveModel::Serializer
  include Serializable
  embed :ids, include: true

  attributes :id, :is_liked
  has_one :user
  has_one :notificable, polymorphic: true
end
