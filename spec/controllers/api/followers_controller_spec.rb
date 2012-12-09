require 'spec_helper'

describe Api::FollowersController do
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

      it 'should respond with success' do
        get_request.call
        response.response_code.should == 200
      end
    end
  end
end

