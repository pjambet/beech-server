class MyProfileSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :check_count,
             :following_count, :follower_count

  has_many :events, root: 'feed'

  def avatar_url
    object.avatar.url
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

