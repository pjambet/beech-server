class AwardSerializer < ActiveModel::Serializer
  include Serializable
  embed :ids, include: true

  attributes :id

  has_one :badge
end

