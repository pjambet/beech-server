require 'spec_helper'

describe Api::FollowersController do
  let(:user) { create :user }
  let(:get_request) { -> { get :index, format: 'json' } }

  describe "GET 'index'" do
    context 'when not logged in' do
      it 'should respond with unauthorized' do
        get_request.call
        response.response_code.should == 401
      end
    end

    context 'when logged in' do
      before(:each) { sign_in user }

      context 'without user_id param' do
        before(:each) do
          @followers = 2.times.map { create :following, follower: user }
          @other_followers = 2.times.map { create :following }
          get :index, format: 'json'
        end
        it 'should return the follower users of the current_user' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']
          users.size.should == user.follower_users.size
          users.map{|u| User.find(u['id'])}.each do |f|
            user.follower_users.should include(f)
          end
        end

        it 'should not return other users' do
          @other_followers.map(&:follower).each do |f|
            user.follower_users.should_not include(f)
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
        it 'should return the follower users of the given user' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']

          users.size.should == inspected_user.follower_users.size
          users.map{|u| User.find(u['id'])}.each do |f|
            inspected_user.follower_users.should include(f)
          end
        end

        it 'should not return other users' do
          @other_followers.map(&:follower).each do |f|
            inspected_user.following_users.should_not include(f)
          end
        end
      end

    end
  end
end

