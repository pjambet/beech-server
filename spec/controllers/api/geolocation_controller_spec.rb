require 'spec_helper'

vcr_options = { cassette_name: 'foursquare/venues' }
describe Api::GeolocationController, vcr: vcr_options do
  context 'when not logged in' do
    describe "GET 'show'" do
      it 'should respond with unauthorized' do
        get :show, format: 'json'
        expect(response.code).to eq('401')
      end
    end
  end

  context 'when logged in' do
    context 'as a regular user' do
      let(:current_user) { create :user }
      let(:check) { create :check }
      before(:each) { sign_in current_user }

    end
  end
end


