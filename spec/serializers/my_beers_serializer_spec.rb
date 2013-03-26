require 'spec_helper'

describe MyBeersSerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:name) }
  it { should have_attribute(:checks_count) }

  it { should include_root }
end

