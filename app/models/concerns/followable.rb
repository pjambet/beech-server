module Followable

  extend ActiveSupport::Concern

  included do
    has_many :followings, foreign_key: :follower_id, class_name: 'Following', dependent: :destroy
    has_many :following_users, through: :followings, source: :followee
    has_many :followers, foreign_key: :followee_id, class_name: 'Following', dependent: :destroy
    has_many :follower_users, through: :followers, source: :follower

    def follow(user)
      following_users << user
    end

    def unfollow(user)
      following_users.destroy user
    end
  end
end

