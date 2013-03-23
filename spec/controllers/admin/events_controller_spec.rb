require 'spec_helper'

describe Admin::EventsController do
  render_views

  it_should_behave_like 'an admin controller', {
    index: :get,
  }

  describe 'GET index' do

    context 'when logged in as a an admin' do
      let(:current_user) { create :user, :admin }
      before(:each) do
        sign_in current_user
        @events = 2.times.map{ create :check }.map(&:event)
        get 'index'
      end

      it 'should assign the events' do
        expect(assigns(:events)).to match_array(@events)
      end
    end
  end
end

