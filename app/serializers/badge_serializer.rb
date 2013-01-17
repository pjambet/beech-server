class BadgeSerializer < ActiveModel::Serializer
  include ApplicationHelper
  attributes :id, :name, :description, :photo_url

  def photo_url
    versions = object.photo.versions
    {"url" => full_url_for_path(object.photo.url)}
      .merge Hash[versions.map { |name, version| [name, { "url" => full_url_for_path(version.url) }] }]
  end

end

