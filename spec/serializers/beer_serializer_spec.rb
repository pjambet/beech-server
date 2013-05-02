require 'spec_helper'

describe BeerSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:name) }
  it { should have_attribute(:font_color) }
  it { should have_attribute(:background_color) }

  it { should embed(:ids) }

  # There's a conflict with shoulda, so those tests don't pass ATM
  xit { should have_one(:beer_color) }

  it { should include_root }
end

