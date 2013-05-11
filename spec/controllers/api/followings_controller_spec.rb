require 'spec_helper'

describe Api::FollowingsController do
  let(:user) { create :user }
  it_should_behave_like 'an api controller', {
    index: :get,
    create: {method: :post, params: {id: 1}},
    destroy: {method: :delete, params: {id: 1}},
  }

  context 'when logged in' do
    before(:each) { sign_in user }

    describe "GET 'index'" do
      context 'without user_id param' do
        before(:each) do
          @followees = 2.times.map { create :following, follower: user }
          @other_followees = 2.times.map { create :following }
          get :index, format: 'json'
        end
        it 'returns the followed users of the current_user' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']
          users.size.should == user.following_users.size
          users.map{|u| User.find(u['id'])}.each do |f|
            user.following_users.should include(f)
          end
        end

        it 'does not return other users' do
          @other_followees.map(&:followee).each do |f|
            user.following_users.should_not include(f)
          end
        end
      end

      context 'with user_id param' do
        let(:inspected_user) { create :user }
        before(:each) do
          @followees = 2.times.map { create :following,
                                     follower: inspected_user }
          @other_followees = 2.times.map { create :following }
          get :index, user_id: inspected_user, format: 'json'
        end
        it 'returns the followed users of the given user' do
          decoded_response = ActiveSupport::JSON.decode(response.body)
          users = decoded_response['users']

          users.size.should == inspected_user.following_users.size
          users.map{|u| User.find(u['id'])}.each do |f|
            inspected_user.following_users.should include(f)
          end
        end

        it 'does not return other users' do
          @other_followees.map(&:followee).each do |f|
            inspected_user.following_users.should_not include(f)
          end
        end
      end
    end

    describe "POST 'create'" do
      before(:each) do
        @followee_user = create :user
        Notifier.any_instance.expects(:create_notification)
        post :create, user_id: @followee_user, format: 'json'
      end

      it 'has created the following association' do
        user.following_users.should include(@followee_user)
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        @following = create :following, follower: user
        delete :destroy,
                id: user,
                user_id: @following.followee_id,
                format: 'json'
      end

      it 'has destroyed the following association' do
        expect { Following.find(@following.id) }.to raise_error(
          ActiveRecord::RecordNotFound)
      end

      it 'is not in the user following list' do
        user.reload.following_users.should_not include(@following.followee)
      end

    end
  end
end

