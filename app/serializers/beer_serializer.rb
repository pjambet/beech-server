class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :count

  def count
    scope.beers_count_for(object)
  end
end

