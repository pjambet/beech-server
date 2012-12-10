require 'spec_helper'

describe Api::AwardsController do
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
          @awards = 5.times.map { create :award, user: user }
          @other_awards = 5.times.map { create :award }
          get :index, format: 'json'
        end

        it 'should return the awards users of the current_user' do
          assigns(:awards).size.should == user.awards.size
          assigns(:awards).each do |a|
            user.awards.should include(a)
          end
        end

        it 'should not return other users' do
          @other_awards.each do |a|
            user.awards.should_not include(a)
          end
        end
      end

      context 'with user_id param' do
        let(:inspected_user) { create :user }
        before(:each) do
          @awards = 4.times.map { create :award, user: inspected_user }
          @other_awards = 5.times.map { create :award }
          get :index, user_id: inspected_user, format: 'json'
        end

        it 'should return the awards users of the current_user' do
          assigns(:awards).size.should == inspected_user.awards.size
          assigns(:awards).each do |a|
            inspected_user.awards.should include(a)
          end
        end

        it 'should not return other users' do
          @other_awards.each do |a|
            inspected_user.awards.should_not include(a)
          end
        end
      end

    end
  end
end

