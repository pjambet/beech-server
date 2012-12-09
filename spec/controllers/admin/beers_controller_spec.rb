require 'spec_helper'

describe Admin::BeersController do
  let(:get_request) { ->{ get :index } }

  it 'FIX RESPONSE CODE ASSERTIONS'

  context 'when not logged in' do
    it 'should respond with unauthorized' do
      get_request.call
      response.response_code.should == 302
    end
  end

  context 'when logged in' do
    before(:each) do
      sign_in user
      get_request.call
    end
    context 'as a regular user' do
      let(:user) { create :user }
      it 'should respond with unauthorized' do
        response.response_code.should == 200
      end
    end

    context 'as an admin' do
      let(:user) { create :user, :admin }
      it 'should respond with success' do
        response.response_code.should == 200
      end
    end
  end
end

