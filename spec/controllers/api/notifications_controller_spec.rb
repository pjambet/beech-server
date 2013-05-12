require 'spec_helper'

describe Api::NotificationsController do
  let(:user) { create :user }

  it_should_behave_like 'an api controller', {
    index: :get,
  }

  describe "GET 'index'" do
    let(:params) { {} }
    let(:beer) { create :beer, beer_color: BeerColor.blond }

    context 'when logged in' do
      before(:each) do
        sign_in user
        get :index, params.merge(format: :json)
      end

      it { response.should be_success }
    end
  end
end

