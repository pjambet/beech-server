require 'spec_helper'
require 'cancan/matchers'

describe User do
  it { should have_many :awards }
  it { should have_many(:badges).through(:awards) }
  it { should have_many(:checks).dependent(:destroy) }
  it { should have_many(:beers).through(:checks) }
  it { should have_many(:events).dependent(:destroy) }
  it { should have_many(:followings) }
  it { should have_many(:following_users).through(:followings) }
  it { should have_many(:followers) }
  it { should have_many(:follower_users).through(:followers) }
  it { should have_many(:memberships) }
  it { should have_many(:roles).through(:memberships) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :nickname }

  context 'with a new instance' do
    subject { create :user }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:nickname) }
  end

  describe '#admin?' do

    context 'with a regular user' do
      subject { create :user }
      it 'should return false' do
        should_not be_admin
      end
    end

    context 'with an admin' do
      subject { create :user, :admin }
      it 'should return true' do
        should be_admin
      end
    end
  end

  describe '.exclude' do
    subject { User.exclude }

    before(:each) { @users = 4.times.map { create :user } }

    context 'without params' do
      its(:size) { should == 4 }
      it { should include(*@users) }
    end

    context 'with a single user' do
      let(:black_listed) { create :user }
      subject(:excluded_users) { User.exclude black_listed }

      its(:size) { should == 4 }
      it { should include(*@users) }
      it { should_not include(black_listed) }
    end

    context 'with users' do
      let(:black_list) { 3.times.map { create :user } }
      subject(:excluded_users) { User.exclude black_list }

      its(:size) { should == 4 }
      it { should include(*@users) }
      it { should_not include(*black_list) }
    end
  end

  describe '#unearned_badges' do
    subject(:user) { create :user }

    context 'without badges in the db' do
      its(:unearned_badges) { should be_empty }
    end

    context 'with badges in the db' do
      context 'when user has already earned everything' do
        before(:each) do
          4.times { subject.badges << create(:badge) }
        end

        its(:unearned_badges) { should be_empty }
      end

      context 'when user has not earned some badges' do
        before(:each) do
          4.times { create :badge }
          3.times { subject.badges << create(:badge) }
        end

        its(:unearned_badges) { should_not be_empty }
        its('unearned_badges.size') { should == 4 }
      end
    end
  end

  describe '#beer_countries' do
    # TODO
  end

  describe '#self_and_following_users' do
    subject(:user) { create :user }

    its(:self_and_following_users) { should include(user) }

    context 'without following users' do
      its('self_and_following_users.length') { should == 1 }
    end

    context 'with following users' do
      before(:each) { 2.times { subject.following_users << create(:user) } }

      its(:self_and_following_users) { should include(*user.following_users) }
    end
  end

  describe 'Filterable behavior' do
    subject { User }
    it { should respond_to(:after) }
  end

  describe '#follow' do
    subject(:user) { create(:user) }
    let(:other_user) { create(:user) }
    before(:each) { user.follow(other_user) }

    its(:following_users) { should include(other_user) }
  end

  describe '#unfollow' do
    subject(:user) { create(:user) }
    let(:other_user) { create(:user) }
    before(:each) do
      user.follow(other_user)
      user.unfollow(other_user)
    end

    its(:following_users) { should_not include(other_user) }
  end

  describe '.find_first_by_auth_conditions' do
    subject { User.find_first_by_auth_conditions(params) }
    let(:user) { create :user, nickname: 'pierre', email: 'pierre@gmail.com' }

    before(:each) { create :user }

    context 'with empty conditions' do
      let(:params) { {} }
      it { should_not be_nil }
    end

    context 'with login condition' do
      context 'is a nickname' do
        let(:params) { {login: 'pierre'} }

        it { should eq(user) }
      end
      context 'is an email' do
        let(:params) { {login: 'pierre@gmail.com'} }

        it { should eq(user) }
      end
    end
  end

  describe '#generate_random_avatar' do
    context 'with a new instance' do
      subject { build :user }

      its(:avatar) { should be_blank }
    end

    context 'with a persisted instance' do
      subject { create :user }

      its(:avatar) { should_not be_blank }
      its('avatar.url') { should match(/original/) }
    end
  end
end
