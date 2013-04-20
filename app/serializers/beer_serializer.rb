class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :country, :color_pattern
  embed :objects, include: true
  has_one :beer_color
end

