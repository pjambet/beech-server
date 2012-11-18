class CheckSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :created_at
  has_one :user
  has_one :beer
end

