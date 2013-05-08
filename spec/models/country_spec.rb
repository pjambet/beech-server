require 'spec_helper'

describe Country do
  it { should have_many(:breweries) }
  it { should have_many(:beers).through(:breweries) }
end
