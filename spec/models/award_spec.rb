require 'spec_helper'

describe Award do
  it { should belong_to :user }
  it { should belong_to :badge }
end
