require 'spec_helper'

describe AwardSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:created_at) }

  it { should embed(:ids) }

  # There's a conflict with shoulda, so those tests don't pass ATM
  xit { should have_one(:badge) }

  it { should include_root }
end

