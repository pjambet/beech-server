class UserSerializer < ActiveModel::Serializer
  include ApplicationHelper
  include Serializable

  embed :ids, include: true

  attributes :id, :email, :nickname, :avatar_url, :already_following

  def avatar_url
    versions = object.avatar.versions
    {"url" => full_url_for_path(object.avatar.url)}
      .merge Hash[versions.map { |name, version| [name, { "url" => full_url_for_path(version.url) }] }]
  end

end

