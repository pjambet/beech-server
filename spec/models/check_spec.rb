require 'spec_helper'

describe Check do
  it { should belong_to :user }
  it { should belong_to :beer }
end
