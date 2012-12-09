require 'spec_helper'

describe Admin::BeersController do
  before(:each) { get :index }

  context 'when not logged in' do
    it 'should respond with unauthorized' do
      response.response_code.should == 401
    end
  end

  context 'when logged in as a regular user' do
    let(:user) { create :user }
    before(:each) do
      sign_in user
    end
    it 'should respond with unauthorized' do
      response.response_code.should == 401
    end
  end

  context 'when logged in as an admin' do
    let(:user) { create :user, :admin }
    before(:each) do
      sign_in user
    end
    it 'should respond with success' do
      response.response_code.should == 200
    end
  end
end

