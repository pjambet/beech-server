class CheckShortSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :created_at
  has_one :beer

  def created_at
    object.created_at.to_i
  end
end

