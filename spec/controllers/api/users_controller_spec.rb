require 'spec_helper'

describe Api::UsersController do
  describe "GET index" do

    context 'when not logged in' do
      it 'should respond with unauthorized' do
        get :index, format: 'json'
        response.response_code.should == 401
      end
    end

    context 'when logged in' do
      let(:user) { create :user }
      before(:each) { sign_in user }

      context 'without query' do
        before(:each) { get :index, format: 'json' }

        it 'should respond with success' do
          response.should be_success
        end
      end

      context 'with a query' do
        before(:each) { get :index, s: "jean-mich" }

        it 'should respond with success' do
          response.should be_success
        end

      end
    end
  end
end

