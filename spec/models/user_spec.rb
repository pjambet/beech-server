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
  it { should have_many(:likes) }
  it { should have_many(:liked_events).through(:likes) }
  it { should have_many(:comments) }
  it { should have_many(:commented_events).through(:comments) }
  it { should have_many(:notifications) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :nickname }

  context 'default per page size' do
    subject { User.per_page }
    it { should eq(10) }
  end

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

  context '#like/#unlike' do
    subject(:user) { create :user }
    let(:event) { create :event }

    describe '#like' do
      before(:each) { user.like event }

      it { user.like?(event).should be_true }

      context 'like an already liked event' do
        it { expect{user.like(event)}.to raise_error(ActiveRecord::RecordInvalid) }
      end
    end

    describe '#unlike' do
      before(:each) do
        user.like event
        user.unlike event
      end

      it { user.like?(event).should be_false }

      context 'unlike an already unliked event' do
        it { expect{user.unlike(event)}.to change{Like.count}.by(0) }
      end
    end
  end
end
