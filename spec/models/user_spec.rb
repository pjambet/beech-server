require 'spec_helper'

describe User do
  it { should have_many :awards }
  it { should have_many( :badges ).through( :awards ) }
  it { should have_many :checks }
  it { should have_many( :beers ).through( :checks ) }
end
