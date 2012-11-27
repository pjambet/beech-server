class CheckSerializer < ActiveModel::Serializer
  include BeechServer::Serializable
  embed :ids, include: true

  attributes :id
  serialized_with_timestamp
  has_one :user
  has_one :beer

end

