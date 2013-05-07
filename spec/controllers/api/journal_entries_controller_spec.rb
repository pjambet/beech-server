require 'spec_helper'

describe Api::JournalEntriesController do
  it_should_behave_like 'an api controller', {
    index: :get,
  }

  context 'when logged in' do
    let(:current_user) { create :user }
    before(:each) {
      sign_in current_user
    }

    describe "GET index" do
      before(:each) { 5.times.map { create :beer } }

      context 'without last id' do
        before(:each) { get :index }

        it { response.response_code.should eq(200) }
      end

      context 'with last id' do
        before(:each) { get :index, last_id: 42 }

        it { response.response_code.should eq(200) }
      end

    end
  end
end

