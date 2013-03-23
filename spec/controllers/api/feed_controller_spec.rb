require 'spec_helper'

describe Api::FeedController do
  let(:user) { create :user }
  let(:get_request) { -> { get :index, format: 'json' } }

  it_should_behave_like 'an api controller', {
    index: :get,
  }

  describe "GET 'index'" do

    context 'when logged in' do
      before(:each) do
        sign_in user
        beer = create :beer, beer_color: BeerColor.blond
        @checks = 2.times.map { create :check, user: user, beer: beer }
      end

      it 'should assign the events' do
        get_request.call
        expect(assigns(:events)).to match_array(@checks.map(&:event))
      end
    end
  end
end

