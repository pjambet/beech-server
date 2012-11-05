# == Schema Information
#
# Table name: beer_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BeerType < ActiveRecord::Base
  attr_accessible :name

  has_many :beers
end
