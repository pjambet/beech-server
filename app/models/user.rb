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
#  avatar_uploaded_at     :datetime
#

class User < ActiveRecord::Base
  include Searchable::Models
  include BeechServer::Models::BadgesChecker
  include Followable
  include Rolable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :nickname, :login, :avatar

  attr_accessor :login

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :token_authenticatable

  mount_uploader :avatar, AvatarUploader
  searchable_by :nickname

  before_save :ensure_authentication_token

  after_create do
    image = File.open("public/default-avatar-#{(rand 4) + 1}.png")
    self.avatar = image
    save!
  end

  has_many :awards
  has_many :badges, through: :awards
  has_many :checks
  has_many :created_beers, class_name: 'Beer', foreign_key: :added_by_id
  has_many :beers, through: :checks
  has_many :events

  validates :email, uniqueness: true
  validates :nickname, presence: true, uniqueness: true

  scope :ordered, -> { order('created_at DESC') }
  scope :exclude, ->(*users) do
    users.flatten!
    if users.any?
      where('id NOT IN (?) ', users.map(&:id))
    else
      scoped
    end
  end

  scope :after, ->(date) do
    if date.to_i > 0
      date = Time.at(date.to_i).utc
      where("date_trunc('second', created_at) > ?", date)
    else
      scoped
    end
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
    beers.where("country = ?", country)
  end

  def beers_for_color(color)
    beers.joins(:beer_color).where(beer_colors: {slug: color})
  end

  def beers_for_name(name)
    beers.where('name = ?', name)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(nickname) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

end

