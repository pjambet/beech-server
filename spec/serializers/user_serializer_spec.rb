require 'spec_helper'

describe UserSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:email) }
  it { should have_attribute(:nickname) }
  it { should have_attribute(:avatar_url) }
  it { should have_attribute(:already_following) }

  it { should embed(:ids) }

  it { should include_root }

  include_examples 'image serializer', {field_name: :avatar}
end
