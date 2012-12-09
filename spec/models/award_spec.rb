require 'spec_helper'

describe Award do
  it { should belong_to :user }
  it { should belong_to :badge }
  it { should have_db_index([:user_id, :badge_id])}
  it { should validate_presence_of(:user)}
  it { should validate_presence_of(:badge)}

  it { should act_as_eventable}
end
