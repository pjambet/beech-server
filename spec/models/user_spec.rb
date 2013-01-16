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
    before(:each) do
      @users = 20.times.map { create :user }
    end

    context 'without params' do
      before(:each) do
        @excluded_users = User.exclude
      end

      it 'should return all users' do
        @excluded_users.size.should == 20
        @users.each do |u|
          @excluded_users.should include(u)
        end
      end

    end

    context 'with a single user' do
      before(:each) do
        @black_listed = create :user
        @excluded_users = User.exclude @black_listed
      end

      it 'should return all users exclude the given one' do
        @excluded_users.size.should == 20
        @users.each do |u|
          @excluded_users.should include(u)
        end
        @excluded_users.should_not include(@black_list)
      end
    end

    context 'with users' do
      before(:each) do
        @black_list = 3.times.map { create :user }
        @excluded_users = User.exclude @black_list
      end

      it 'should return all users' do
        @excluded_users.size.should == 20
        @users.each do |u|
          @excluded_users.should include(u)
        end
        @black_list.each do |u|
          @excluded_users.should_not include(u)
        end
      end
    end
  end

  describe '#unearned_badges' do
    subject { create :user }

    context 'without badges in the db' do
      it 'should return an empty list' do
        subject.unearned_badges.should be_empty
      end
    end

    context 'with badges in the db' do
      context 'when user has already earned everything' do
        before(:each) do
          4.times { subject.badges << create(:badge) }
        end

        it 'should return an empty list' do
          subject.unearned_badges.should be_empty
        end
      end

      context 'when user has not earned some badges' do
        before(:each) do
          4.times { create :badge }
          3.times { subject.badges << create(:badge) }
        end
        it 'should return those badges' do
          subject.unearned_badges.should_not be_empty
          subject.unearned_badges.size.should == 4
        end
      end
    end
  end

  describe '#beer_countries' do
    # TODO
  end

  describe '#self_and_following_users' do
    subject { create :user }

    it 'should include the user in the result' do
      subject.self_and_following_users.should include(subject)
    end

    context 'without following users' do
      it 'should return only the user' do
        subject.self_and_following_users.length.should == 1
      end
    end

    context 'with following users' do
      it 'should return all following users' do
        2.times { subject.following_users << create(:user) }
        subject.following_users.each do |user|
          subject.self_and_following_users.should include(user)
        end
      end
    end
  end

  describe 'Avatar random assignation' do
    subject { build :user }

    it 'should have an avatar after being saved' do
      subject.avatar.should be_blank
      subject.save
      subject.avatar.should_not be_blank
    end
  end
end
