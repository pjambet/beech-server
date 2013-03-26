require 'spec_helper'

describe Api::MyBadgesController do
  let(:user) { create :user, :with_awards }

  it_should_behave_like 'an api controller', {
    index: :get,
  }

  context 'when logged in' do
    before(:each) { sign_in user }
    describe "GET 'index'" do
      context 'with an id' do

        before(:each) { get :index }

        it 'should respond with success' do
          response.response_code.should == 200
        end

        it 'should assigns the @badges' do
          assigns(:badges).length.should == 2
        end
      end

      context 'without user_id param' do
        before(:each) do
          @awards = 2.times.map { create :award, user: user }
          @other_awards = 2.times.map { create :award }
          get :index, format: 'json'
        end

        it 'should return the badges users of the current_user' do
          assigns(:badges).size.should == user.badges.size
          assigns(:badges).each do |badge|
            user.badges.should include(badge)
          end
        end

        it 'should not return other users' do
          @other_awards.each do |badge|
            user.badges.should_not include(badge)
          end
        end
      end

      context 'with user_id param' do
        let(:inspected_user) { create :user }
        before(:each) do
          @awards = 2.times.map { create :award, user: inspected_user }
          @other_awards = 2.times.map { create :award }
          get :index, user_id: inspected_user, format: 'json'
        end

        it 'should return the badges users of the current_user' do
          assigns(:badges).size.should == inspected_user.badges.size
          assigns(:badges).each do |badge|
            inspected_user.badges.should include(badge)
          end
        end

        it 'should not return other badges' do
          @other_awards.each do |badge|
            inspected_user.badges.should_not include(badge)
          end
        end
      end
    end
  end
end

