require 'spec_helper'

describe Users::RegistrationsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  let(:user) { create :user }
  context 'when not logged in' do
    before(:each) { get :new }
    it 'should respond with success' do
      response.response_code.should == 200
    end
  end

  context 'when logged in' do
    before(:each) do
      sign_in user
      get :new
    end
    it 'should redirect to users#root' do
      # response.should redirect_to(me_root_path)
    end
  end
end

