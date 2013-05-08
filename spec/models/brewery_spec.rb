require 'spec_helper'

describe Brewery do
  it { should belong_to(:country) }
  it { should have_many(:beers) }
end
