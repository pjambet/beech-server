require 'spec_helper'

describe Beer do
  it { should belong_to :beer_type }
  it { should have_many :checks }
  it { should have_many( :users ).through( :checks ) }
  it { described_class.should respond_to :search_for}

end
