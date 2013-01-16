require 'spec_helper'

describe Api::MyBeersController do
  let(:user) { create :user, :with_checks }

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

        let(:other_user) { create :user }
        before(:each) { get :index }

        it 'should respond with success' do
          response.response_code.should == 200
        end

        it 'should assigns the @beers' do
          assigns(:beers).length.should == 3
        end
      end
    end
  end
end

