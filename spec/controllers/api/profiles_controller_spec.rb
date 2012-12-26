require 'spec_helper'

describe Api::ProfilesController do
  let(:user) { create :user }
  context 'when not logged in' do
    describe "GET 'show'" do
      it 'should respond with unauthorized' do
        get :show, id: user, format: 'json'
        response.response_code.should == 401
      end
    end
  end

  context 'when logged in' do
    before(:each) { sign_in user }
    describe "GET 'show'" do
      it 'should respond with success' do
        get :show, id: user, format: 'json'
        response.response_code.should == 200
      end
    end

    describe "PUT 'update'" do
      context 'on himself' do
        before(:each) { put :update, format: 'json' }
        it 'should repond with success' do
          response.should be_success
        end
      end

    end

  end
end

