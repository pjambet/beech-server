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
#

class Beer < ActiveRecord::Base
  include Searchable::Models
  include Pageable

  attr_accessible :name, :beer_color, :beer_color_id

  acts_as_pageable

  belongs_to :beer_color
  has_many :checks
  has_many :users, through: :checks

  delegate :name, to: :beer_color, prefix: :true

end

