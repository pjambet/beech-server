module Serializable

  extend ActiveSupport::Concern

  module ClassMethods
    def serialiaze_image_as(image_field_name, opts={})
      self.image_field_name = image_field_name
    end

    attr_accessor :image_field_name

  end

  included do
    attributes :created_at

    def created_at
      object.created_at.to_i
    end

    def already_following
      return false if scope.nil?
      followings = options[:followings] || scope.following_users
      followings.include?(object)
    end

    def image_url
      versions = object.send(self.class.image_field_name).versions
      {url: object.send(self.class.image_field_name).url}
      .merge(Hash[versions.map { |name, version|
        [name, { url: (version.url) }]
      }])
    end

  end
end

