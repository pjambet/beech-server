class BeerColorSerializer < ActiveModel::Serializer
  include Serializable

  attributes :id, :name, :slug
end

