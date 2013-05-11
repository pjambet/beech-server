require 'spec_helper'

describe Api::FollowersController do
  let(:user) { create :user }

  it_should_behave_like 'an api controller', {
    index: :get,
  }

  describe "GET 'index'" do

    context 'when logged in' do
      before(:each) { sign_in user }

      context 'without user_id param' do
        before(:each) do
          @followers = 2.times.map { create :following, followee: user }
          @other_followers = 2.times.map { create :following }
          get :index, format: 'json'
        end

        it 'returns the follower users of the current_user' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']
          users.size.should == user.follower_users.size
          users.map{|u| User.find(u['id'])}.each do |f|
            user.follower_users.should include(f)
          end
        end

        it 'does not return other users' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']
          users.size.should == user.follower_users.size
          @other_followers.map(&:follower).each do |f|
            users.should_not include(f)
          end
        end

        it 'returns false for already following' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']
          users.each do |user|
            user['already_following'].should eq(false)
          end
        end

      end

      context 'with user_id param' do
        let(:inspected_user) { create :user }
        before(:each) do
          @followers = 2.times.map { create :following,
                                     follower: inspected_user }
          @other_followers = 2.times.map { create :following }
          get :index, user_id: inspected_user, format: 'json'
        end
        it 'returns the follower users of the given user' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']

          users.size.should == inspected_user.follower_users.size
          users.map{|u| User.find(u['id'])}.each do |f|
            inspected_user.follower_users.should include(f)
          end
        end

        it 'does not return other users' do
          @other_followers.map(&:follower).each do |f|
            inspected_user.following_users.should_not include(f)
          end
        end
      end

    end
  end
end

