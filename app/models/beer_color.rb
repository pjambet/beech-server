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
  attr_accessible :name, :slug

  has_many :beers

  class << self
    %w(blond dark white amber ale stout).each do |beer_color|
      define_method beer_color do
        find_or_create_by(slug: beer_color)
      end
    end
  end
end
