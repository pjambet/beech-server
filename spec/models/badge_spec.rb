require 'spec_helper'

describe Badge do
  it { should have_many :awards }
  it { should have_many( :users ).through( :awards ) }
end
