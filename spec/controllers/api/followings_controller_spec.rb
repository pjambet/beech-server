require 'spec_helper'

describe Api::FollowingsController do
  let(:user) { create :user }
  context 'when not logged in' do

  end

  context 'when logged in' do
    before(:each) { sign_in user }

    describe "GET 'index'" do
      before(:each) do
        @followees = 5.times.map { create :following, follower: user }
        @other_followees = 5.times.map { create :following }
        get 'index'
      end

      it 'should return the followed users' do
        @followees.map(&:followee).each do |f|
          user.following_users.should include(f)
        end
      end

      it 'should not return other users' do
        @other_followees.map(&:followee).each do |f|
          user.following_users.should_not include(f)
        end
      end
    end

    describe "POST 'create'" do
      before(:each) do
        @followee_user = create :user
        post 'create', user_id: @followee_user
      end

      it 'should have created the following association' do
        user.following_users.should include(@followee_user)
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        @following = create :following, follower: user
        delete 'destroy', id: user, user_id: @following.followee_id
      end

      it 'should have destroyed the following association' do
        expect { Following.find(@following.id) }.to raise_error
      end

    end
  end
end

