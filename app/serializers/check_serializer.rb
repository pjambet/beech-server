class CheckSerializer < ActiveModel::Serializer
  include Serializable
  embed :ids, include: true

  attributes :id
  has_one :user
  has_one :beer

end

