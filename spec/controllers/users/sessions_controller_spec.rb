require 'spec_helper'

describe Users::SessionsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  let(:user) { create :user }

  context "GET 'new'" do
    context 'when not logged in' do
      it 'responds with success' do
        get :new
        response.response_code.should == 200
      end
    end

    context 'when logged in' do
      before(:each) do
        sign_in user
        get :new
      end

      it { response.should redirect_to(user_path(user)) }
    end
  end

  context "POST 'create'" do

    context 'when not logged in' do
      before(:each) do
        post :create, user: {login: user.nickname, password: user.password}
      end

      its(:current_user) { should_not be_nil }
      it { response.should redirect_to(user_path(user)) }
    end

    context 'when already logged in' do
      before(:each) do
        sign_in user
        post :create
      end

      it { response.should redirect_to(user_path(user)) }
    end
  end
end
