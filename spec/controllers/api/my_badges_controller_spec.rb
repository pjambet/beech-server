require 'spec_helper'

describe Api::MyBadgesController do
  let(:user) { create :user, :with_awards }

  context 'when not logged in' do
    describe "GET 'index'" do
      it 'should respond with unauthorized' do
        get :index, format: 'json'
        response.response_code.should == 401
      end
    end
  end

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
    end
  end
end

