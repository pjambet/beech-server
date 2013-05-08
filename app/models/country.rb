# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  country_code :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Country < ActiveRecord::Base
  attr_accessible :name, :country_code

  has_many :breweries
  has_many :beers, through: :breweries
end
