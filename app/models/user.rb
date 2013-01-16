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
#

class User < ActiveRecord::Base
  include Searchable::Models
  include BeechServer::Models::BadgesChecker
  include Followable
  include Rolable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :nickname

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :token_authenticatable

  mount_uploader :avatar, AvatarUploader
  searchable_by :nickname

  before_save :ensure_authentication_token

  has_many :awards
  has_many :badges, through: :awards
  has_many :checks
  has_many :beers, through: :checks
  has_many :events

  validates :email, presence: true, uniqueness: true
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

end

