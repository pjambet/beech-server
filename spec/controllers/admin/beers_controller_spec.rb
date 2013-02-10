require 'spec_helper'

describe Admin::BeersController do
  let(:get_request) { ->{ get :index } }


  context 'when not logged in' do
    it 'should redirect to sign_in form' do
      get_request.call
      expect(response.code).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in' do
    before(:each) do
      sign_in user
      get_request.call
    end
    context 'as a regular user' do
      let(:user) { create :user }
      it 'should redirect to sign_in page' do
        response.should redirect_to(new_user_session_path)
      end
    end

    context 'as an admin' do
      let(:user) { create :user, :admin }
      it 'should respond with success' do
        expect(response.code).to eq('200')
      end
    end
  end
end

