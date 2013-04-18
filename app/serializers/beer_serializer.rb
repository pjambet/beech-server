class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :color_pattern
  embed :ids, include: true
  has_one :beer_color
end

