require 'spec_helper'

describe MyProfileSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:email) }
  it { should have_attribute(:nickname) }
  it { should have_attribute(:check_count) }
  it { should have_attribute(:following_count) }
  it { should have_attribute(:follower_count) }
  it { should have_attribute(:avatar_url) }
  it { should have_attribute(:already_following) }

  it { should embed(:ids) }

  # There's a conflict with shoulda, so those tests don't pass ATM
  xit { should have_many(:events) }
  xit { should have_many(:badges) }

  it { should include_root }

  include_examples 'image serializer', {
    field_name: :avatar,
    factory_name: :user
  }
end

