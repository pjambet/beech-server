require 'spec_helper'

describe User do
  it { should have_many :awards }
  it { should have_many(:badges).through(:awards) }
  it { should have_many :checks }
  it { should have_many(:beers).through(:checks) }
  it { should have_many(:events) }
  it { should have_many(:followings) }
  it { should have_many(:following_users).through(:followings) }
  it { should have_many(:followers) }
  it { should have_many(:follower_users).through(:followers) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :nickname }

  describe '.except' do
    # TODO
  end
end
