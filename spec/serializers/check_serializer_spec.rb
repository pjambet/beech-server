require 'spec_helper'

describe CheckSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:created_at) }

  it { should embed(:ids) }

  # There's a conflict with shoulda, so those tests don't pass ATM
  xit { should have_one(:beer) }
  xit { should have_one(:user) }

  it { should include_root }
end

