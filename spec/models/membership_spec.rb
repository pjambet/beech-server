require 'spec_helper'

describe Membership do

  it { should belong_to(:role) }
  it { should belong_to(:user) }
  it { should have_db_index([:role_id, :user_id]) }

end

