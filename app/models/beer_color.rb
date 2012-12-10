# == Schema Information
#
# Table name: beer_colors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BeerColor < ActiveRecord::Base
  attr_accessible :name

  has_many :beers

  class << self
    def blond
      find_or_create_by_slug('blond')
    end
  end
end
