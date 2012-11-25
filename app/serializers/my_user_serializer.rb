class MyUserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :check_count,
             :following_count, :follower_count

  # has_many :beers
  has_many :checks, serializer: CheckShortSerializer
  # has_many :awards, embed: :objects
  # has_many :badges, embed: :objects

  def avatar_url
    root_url + object.avatar.url
  end

  def check_count
    object.checks.size
  end

  def follower_count
    object.followers.size
  end

  def following_count
    object.followings.size
  end
end

