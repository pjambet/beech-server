# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :nickname

  mount_uploader :avatar, AvatarUploader

  has_many :awards
  has_many :badges, through: :awards
  has_many :checks
  has_many :beers, through: :checks

  has_many :followings, foreign_key: :follower_id, class_name: 'Following'
  has_many :following_users, through: :followings, source: :followee
  has_many :followers, foreign_key: :followee_id, class_name: 'Following'
  has_many :follower_users, through: :followers, source: :follower

  validates :email, presence: true
  validates :nickname, presence: true

  scope :except, ->(users = []) do
    users = [users] unless users.is_a?(Array)
    where('id NOT IN (?) ', users.map(&:id))
  end

end

