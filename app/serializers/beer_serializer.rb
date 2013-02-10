class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :beer_color

end

