require 'spec_helper'

describe BeerType do
  it { should have_many :beers }
end
