require 'spec_helper'

describe Api::MyBeersController do
  let(:user) { create :user, :with_checks }

  it_should_behave_like 'an api controller', {
    index: :get,
  }

  context 'when logged in' do
    before(:each) { sign_in user }
    describe "GET 'index'" do
      context 'without an id' do

        let(:other_user) { create :user }
        before(:each) { get :index }

        it 'should assigns the @beers' do
          assigns(:beers).length.should == 3
        end
        it "assigns all beers to @beers" do
          ['Kronembourg', 'Stella Artois', 'Guiness'].each do |b|
            assigns(:beers).map(&:name).should include b
          end
        end

      end
    end
  end
end

