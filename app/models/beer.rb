# == Schema Information
#
# Table name: beers
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  country          :string(255)
#  beer_color_id    :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  accepted         :boolean
#  added_by_id      :integer
#  font_color       :string(255)
#  background_color :string(255)
#  brewery_id       :integer
#

class Beer < ActiveRecord::Base
  include Searchable::Models
  include Loggable

  COLOR_POOL = [
    ['#000000', '#ffffff'],
    ['#00C57D', '#ffffff'],
    ['#FF5800', '#ffffff'],
    ['#FF9C00', '#ffffff'],
    ['#FF4233', '#ffffff'],
    ['#0089C6', '#ffffff'],
  ]

  attr_accessible :name, :beer_color, :beer_color_id, :country, :font_color,
    :background_color

  searchable_by :name

  after_create :assign_color

  belongs_to :beer_color
  belongs_to :brewery
  belongs_to :added_by, class_name: 'User'
  has_many :checks, dependent: :destroy
  has_many :users, through: :checks

  default_scope -> { includes(:beer_color) }

  scope :ordered, -> do
    select('beers.id, beers.name, COUNT(DISTINCT(checks.id)) AS checks_count')
    .joins(:checks).order('checks_count DESC').group("beers.id")
  end

  scope :with_color, -> { includes(:beer_color, :added_by) }
  scope :suggested, -> { where('accepted IS NULL').with_color }
  scope :accepted, -> { where('accepted IS TRUE').with_color }
  scope :rejected, -> { where('accepted IS FALSE').with_color }

  delegate :name, to: :beer_color, prefix: true, allow_nil: true

  validates :name, presence: true

  def should_be_logged?
    self.accepted
  end

  def assign_color
    random_pattern = COLOR_POOL[rand(COLOR_POOL.length)]
    self.update_column :background_color, random_pattern[0]
    self.update_column :font_color, random_pattern[1]
  end
end

