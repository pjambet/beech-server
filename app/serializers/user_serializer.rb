class UserSerializer < ActiveModel::Serializer
  include ApplicationHelper
  include Serializable

  serialiaze_image_as :avatar

  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :already_following

  def avatar_url
    image_url
  end
end

