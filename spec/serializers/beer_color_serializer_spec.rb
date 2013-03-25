require 'spec_helper'

describe BeerColorSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:name) }
  it { should have_attribute(:slug) }
  it { should have_attribute(:created_at) }

  it { should include_root }
end

