require 'spec_helper'

describe Api::BeersController do
  it_should_behave_like 'an api controller', {
    index: :get,
    create: :post,
  }

  context 'when logged in' do
    context 'as a regular user' do
      let(:current_user) { create :user }
      before(:each) {
        sign_in current_user
        Beer.stubs(:per_page).returns 3
      }

      describe "GET index" do
        before(:each) { 5.times.map { create :beer } }

        context 'without query' do
          before(:each) { get :index, format: 'json' }

          it { assigns(:beers).size.should > 0 }
          it { assigns(:beers).size.should == 3 }
        end

        context 'with a query' do
          let(:query) { 'guinness' }
          before(:each) do
            create :beer, name: 'guinnes'
            create :beer, name: 'guinness'

            get :index, s: query
          end

          it { assigns(:beers).size.should > 0 }
          it { assigns(:beers).size.should <= 20 }

          it 'returns results which match query' do
            reg = %r{#{query}}
            assigns(:beers).each do |beer|
              beer.name.should match reg
            end
          end

        end
      end

      describe "POST 'create'" do
        let(:params) { {} }
        let(:do_request) { post :create, beer: params }
        context "with incorrect params" do
          it 'does not create a beer' do
            expect{do_request}.to change{Beer.count}.by(0)
          end

          it 'should return an error message'
        end

        context "with correct params" do
          let(:params) { {name: 'Guinness'} }

          it { expect{do_request}.to change{Beer.count}.by(1) }
          it { expect{do_request}.to change{current_user.created_beers.count}.by(1) }
          it { expect{do_request}.to change{ActionMailer::Base.deliveries.count}.by(1) }

          it 'should return the beer' do
            do_request
            json_response = JSON.parse(response.body)
            json_response.should_not be_nil
            json_response.should have_key('beer')
            json_response['beer']['name'].should eq('Guinness')
          end
        end
      end
    end
  end
end

