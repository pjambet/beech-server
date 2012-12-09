require 'spec_helper'

describe UsersController do
  describe "GET index" do

    context 'when not logged in' do
      it
    end

    context 'when logged in' do
      let(:user) { create :user }
      before(:each) do
        sign_in user
      end
      context 'without query' do
        before(:each) { get :index }

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

