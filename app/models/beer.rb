# == Schema Information
#
# Table name: beers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  country       :string(255)
#  beer_color_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  accepted      :boolean
#  added_by_id   :integer
#

class Beer < ActiveRecord::Base
  include Searchable::Models

  NUMBER_OF_COLOR_PATTERNS = 3

  attr_accessible :name, :beer_color, :beer_color_id, :country

  searchable_by :name

  belongs_to :beer_color
  belongs_to :added_by, class_name: 'User'
  has_many :checks
  has_many :users, through: :checks

  after_create :assign_color_pattern

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

  def assign_color_pattern
    self.color_pattern = rand(NUMBER_OF_COLOR_PATTERNS)
    self.save
  end
end

