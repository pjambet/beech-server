require 'spec_helper'

describe LikeSerializer do
  it { should have_attribute(:id) }

  it { should embed(:ids) }

  # There's a conflict with shoulda, so those tests don't pass ATM
  xit { should have_one(:event) }
  xit { should have_one(:user) }

  it { should include_root }
end

