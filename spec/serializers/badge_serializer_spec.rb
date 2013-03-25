require 'spec_helper'

describe BadgeSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:name) }
  it { should have_attribute(:description) }
  it { should have_attribute(:photo_url) }

  it { should include_root }

  include_examples 'image serializer'
end

