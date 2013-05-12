# == Schema Information
#
# Table name: breweries
#
#  id         :integer          not null, primary key
#  country_id :integer
#  name       :string(255)
#  address    :string(255)
#  city       :string(255)
#  zipcode    :string(255)
#  phone      :string(255)
#  website    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lat        :float
#  lng        :float
#

class Brewery < ActiveRecord::Base
  belongs_to :country
  has_many :beers

  after_create :geolocate

  def geolocate
    # TODO : set lat/lng based on the address
  end
end
