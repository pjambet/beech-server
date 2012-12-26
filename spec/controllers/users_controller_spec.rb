require 'spec_helper'

describe UsersController do

  describe "GET show" do
    let(:user) { create :user }
    it "should respond with success" do
      sign_in(user)
      get :show, id: user
      response.response_code.should == 200
    end
  end
end

