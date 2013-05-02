class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :font_color, :background_color

  embed :ids, include: true
  has_one :beer_color

end

