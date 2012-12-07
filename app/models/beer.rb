# == Schema Information
#
# Table name: beers
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  beer_type_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Beer < ActiveRecord::Base
  include BeechServer::Searchable::Models
  attr_accessible :name, :beer_type, :beer_type_id

  acts_as_searchable

  belongs_to :beer_type
  has_many :checks
  has_many :users, through: :checks

  delegate :name, to: :beer_type, prefix: :true

end
