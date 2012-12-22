# == Schema Information
#
# Table name: badges
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  badge_type   :string(255)
#  condition    :text
#  quantity     :integer
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Badge < ActiveRecord::Base
  attr_accessible :name

  has_many :awards
  has_many :users, through: :awards

  validates :condition, presence: true

  attr_accessible :condition, :name, :badge_type, :quantity

end
