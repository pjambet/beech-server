# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nickname               :string(255)
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
#  avatar                 :string(255)
#  authentication_token   :string(255)
#

class User < ActiveRecord::Base
  include Searchable::Models
  include Followable
  include Rolable
  include Filterable
  include Liker
  include Commenter

  attr_accessor :login

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  searchable_by :nickname

  self.per_page = 10

  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  after_create :generate_random_avatar

  has_many :awards
  has_many :badges, through: :awards
  has_many :checks, dependent: :destroy
  has_many :created_beers, class_name: 'Beer', foreign_key: :added_by_id
  has_many :beers, through: :checks
  has_many :events, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :email, uniqueness: true
  validates :nickname, presence: true, uniqueness: {case_sensitive: false}

  scope :ordered, -> { order('created_at DESC') }
  scope :exclude, ->(*users) do
    users.flatten!
    where('id NOT IN (?) ', users.map(&:id)) if users.any?
  end

  def self_and_following_users
    following_users + [self]
  end

  def beers_count_for(beer)
    beers.where(id: beer.id).size
  end

  def beer_countries
    beers.map(&:country)
  end

  def beers_for_country(country)
    beers.where('country = ?', country)
  end

  def beers_for_color(color)
    beers.joins(:beer_color).where(beer_colors: {slug: color})
  end

  def beers_for_name(name)
    beers.where('name = ?', name)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    user_request = self.all
    if login = conditions.delete(:login)
      user_request = user_request.where(
        'lower(nickname) = :value OR lower(email) = :value',
        value: login.downcase)
    end
    user_request.where(conditions).first
  end

  def generate_random_avatar
    image = File.open("public/default-avatar-#{(rand 4) + 1}.png")
    self.avatar = image
    save!
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end

