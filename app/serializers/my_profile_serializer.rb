class MyProfileSerializer < ActiveModel::Serializer
  include ApplicationHelper
  include Serializable

  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :check_count,
             :following_count, :follower_count, :already_following

  has_many :events, root: 'feed'
  has_many :badges

  def events
    @options[:events]
  end

  def avatar_url
    versions = object.avatar.versions
    {"url" => full_url_for_path(object.avatar.url)}
      .merge Hash[versions.map { |name, version| [name, { "url" => full_url_for_path(version.url) }] }]
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

