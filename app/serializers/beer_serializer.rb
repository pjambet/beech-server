class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name
  embed :ids, include: true
  has_one :beer_color

end

