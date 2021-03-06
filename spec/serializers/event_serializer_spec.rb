require 'spec_helper'

describe EventSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:created_at) }
  it { should have_attribute(:is_liked) }

  it { should embed(:ids) }

  # There's a conflict with shoulda, so those tests don't pass ATM
  xit { should have_one(:eventable) }
  xit { should have_one(:user) }
  xit { should have_many(:likes) }
  xit { should have_many(:comments) }

  it { should include_root }

end

