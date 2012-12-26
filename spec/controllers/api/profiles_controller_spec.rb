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
      context 'without id' do
        before(:each) { get :show, format: 'json' }
        it 'should respond with success' do
          response.response_code.should == 200
        end

        it 'should return the current user' do
          expect(assigns(:user)).to eq(user)
        end
      end
      context 'with an id' do
        let(:other_user) { create :user }
        before(:each) { get :show, id: other_user, format: 'json' }
        it 'should respond with success' do
          response.response_code.should == 200
        end

        it 'should return the user with the given id' do
          expect(assigns(:user)).to eq(other_user)
        end
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

