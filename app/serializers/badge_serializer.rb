class BadgeSerializer < ActiveModel::Serializer
  include Serializable

  serialiaze_image_as :photo

  attributes :id, :name, :description, :photo_url

  def photo_url
    image_url
  end

end

