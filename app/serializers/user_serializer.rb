class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :already_following

  def avatar_url
    root_url + object.avatar.url
  end

  def already_following
    return false if scope.nil?
    followings = options[:followings] || scope.following_users
    followings.include?(object)
  end

end

