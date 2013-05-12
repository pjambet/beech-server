# == Schema Information
#
# Table name: badges
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  badge_type     :string(255)
#  condition      :text
#  quantity       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  description_fr :text
#  photo          :string(255)
#  published      :boolean
#  description_en :text
#

class Badge < ActiveRecord::Base
  has_many :awards, dependent: :destroy
  has_many :users, through: :awards

  validates :condition, presence: true

  mount_uploader :photo, BadgePhotoUploader

  scope :ordered, -> { order('created_at DESC') }
  scope :published, -> { where('published IS TRUE') }

  def description(locale = I18n.default_locale)
    if I18n.available_locales.include?(locale)
      send("description_#{locale}")
    else
      send("description_#{I18n.default_locale}")
    end
  end
end
