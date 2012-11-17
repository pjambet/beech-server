require 'spec_helper'

describe Check do
  it { should belong_to :user }
  it { should belong_to :beer }

  it { should validate_presence_of :user }
  it { should validate_presence_of :beer }

  context "with a new instance" do
    subject { create :check }

    it { should validate_uniqueness_of(:user_id).scoped_to(:beer_id) }
    it { should validate_uniqueness_of(:beer_id).scoped_to(:user_id) }
  end
end
