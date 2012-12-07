require 'spec_helper'

describe BeersController do
  describe "GET index" do

    context 'without query' do
      before(:each) { get :index }

      it 'should respond with success' do
        response.should be_success
      end
    end

    context 'with a query' do
      before(:each) { get :index, s: "guiness" }

      it 'should respond with success' do
        response.should be_success
      end

    end
  end
end

