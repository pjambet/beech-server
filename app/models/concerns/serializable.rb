module Serializable

  extend ActiveSupport::Concern

  included do
    attributes :created_at

    define_method :created_at do
      object.created_at.to_i
    end

    define_method :already_following do
      return false if scope.nil?
      followings = options[:followings] || scope.following_users
      followings.include?(object)
    end

  end
end

