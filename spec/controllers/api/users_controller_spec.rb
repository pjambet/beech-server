require 'spec_helper'

describe Api::UsersController do
  context 'when not logged in' do
    describe "GET index" do
      it 'should respond with unauthorized' do
        get :index, format: 'json'
        response.response_code.should == 401
      end
    end

    describe "GET 'show'" do
      it 'should respond with unauthorized' do
        user = create :user
        get :show, id: user, format: 'json'
        response.response_code.should == 401
      end
    end
  end

  context 'when logged in' do
    let(:user) { create :user }
    before(:each) { sign_in user }

    describe "GET 'index'" do
      context 'without query' do
        before(:each) { get :index, format: 'json' }

        it 'should respond with success' do
          response.should be_success
        end
      end

      context 'with a query' do
        before(:each) do
          create :user, nickname: 'jean-michel'
          create :user, nickname: 'jacky'
          get :index, s: "jean-mich"
        end

        it 'should respond with success' do
          response.should be_success
        end

        it 'should only return users matching query' do
          assigns(:users).length.should == 1
          assigns(:users).map(&:nickname).should include('jean-michel')
        end
      end
    end

    describe "GET 'show'" do
      it 'should respond with success' do
        user = create :user
        get :show, id: user
        response.should be_success
      end
    end
  end
end

