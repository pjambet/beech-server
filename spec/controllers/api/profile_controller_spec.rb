require 'spec_helper'

describe Api::ProfileController do
  let(:user) { create :user }
  context 'when not logged in' do
    describe "GET 'index'" do
      it 'should respond with unauthorized' do
        get :index, format: 'json'
        response.response_code.should == 401
      end
    end
    describe "GET 'show'" do
      it 'should respond with unauthorized' do
        get :show, id: user, format: 'json'
        response.response_code.should == 401
      end
    end
  end

  context 'when logged in' do
    before(:each) { sign_in user }
    describe "GET 'index'" do
      it 'should respond with success' do
        get :index, format: 'json'
        response.response_code.should == 200
      end
    end
    describe "GET 'show'" do
      it 'should respond with success' do
        get :show, id: user, format: 'json'
        response.response_code.should == 200
      end
    end
  end
end

