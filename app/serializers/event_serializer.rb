class EventSerializer < ActiveModel::Serializer
  include Serializable
  embed :ids, include: true

  attributes :id, :is_liked
  has_one :eventable, polymorphic: true
  has_one :user
  has_many :comments
  has_many :likes

  def is_liked
    return false if scope.nil?
    if options[:liked_events]
      scope.like?(object, events: options[:liked_events].to_a)
    else
      scope.like?(object)
    end
  end

end
