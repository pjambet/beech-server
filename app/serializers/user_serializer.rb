class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :email, :nickname
  has_many :beers
  has_many :checks, serializer: CheckShortSerializer
  has_many :awards, embed: :objects
  has_many :badges, embed: :objects
end

