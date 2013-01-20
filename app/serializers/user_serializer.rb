class UserSerializer < ActiveModel::Serializer
  include ApplicationHelper
  include Serializable

  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :already_following

  def avatar_url
    object.avatar.url
  end

end

