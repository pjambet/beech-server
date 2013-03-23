require 'spec_helper'

describe Admin::EventsController do
  render_views

  describe 'GET index' do
    context 'when not logged in' do
      it 'should redirect to the login form' do
        get 'index'
        response.should redirect_to(new_user_session_path)
      end
    end

    context 'when logged in as a regular user' do
      let(:current_user) { create :user }
      before(:each) { sign_in current_user }

      it 'should redirect to the login form' do
        get 'index'
        response.should redirect_to(new_user_session_path)
      end
    end

    context 'when logged in as a an admin' do
      let(:current_user) { create :user, :admin }
      let(:events) { 2.times.map{ create :event } }
      before(:each) do
        User.any_instance.stubs(:admin?).returns(true)
        sign_in current_user
        get 'index'
      end

      it 'should respond with success' do
        response.response_code.should == 200
      end
    end
  end
end

