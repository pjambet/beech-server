require 'spec_helper'

describe Following do
  it { should belong_to :follower }
  it { should belong_to :followee }

  it { should validate_presence_of :follower }
  it { should validate_presence_of :followee }

  it { should have_db_index [:follower_id, :followee_id]}
end
