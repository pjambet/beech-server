require 'spec_helper'

describe Api::FeedController do
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
      before(:each) do
        sign_in user
        beer = create :beer, beer_color: BeerColor.blond
        2.times { create :check, user: user, beer: beer }
      end

      it 'should respond with success' do
        get_request.call
        response.response_code.should == 200
      end
    end
  end
end

