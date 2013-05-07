require 'spec_helper'

describe JournalEntrySerializer do
  it { should have_attribute(:id) }
  it { should have_attribute(:entry_type) }
  it { should have_attribute(:loggable_type) }
  it { should have_attribute(:loggable_id) }

  it { should embed(:objects) }

  # There's a conflict with shoulda, so those tests don't pass ATM
  xit { should have_one(:loggable) }

  it { should include_root }
end

