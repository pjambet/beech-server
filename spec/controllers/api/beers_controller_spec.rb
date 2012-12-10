require 'spec_helper'

describe Api::BeersController do
  context 'when not logged in' do
    describe "GET 'index'" do
      it 'should respond with unauthorized' do
        get :index, format: 'json'
        expect(response.code).to eq('401')
      end
    end
  end

  context 'when logged in' do
    context 'as a regular user' do
      let(:current_user) { create :user }
      before(:each) { sign_in current_user }
      describe "GET index" do
        before(:each) { 25.times.map { create :beer } }

        context 'without query' do
          before(:each) { get :index }

          it 'should respond with success' do
            response.should be_success
          end

          it 'should return results' do
            assigns(:beers).size.should > 0
          end

          it 'should paginate results' do
            assigns(:beers).size.should == 20
          end
        end

        context 'with a query' do
          let(:query) { 'guiness' }
          before(:each) do
            create :beer, name: 'guines'
            create :beer, name: 'guiness'

            get :index, s: query
          end

          it 'should respond with success' do
            response.should be_success
          end

          it 'should return results' do
            assigns(:beers).size.should > 0
          end

          it 'should paginate results' do
            assigns(:beers).size.should <= 20
          end

          it 'should only return results which match query' do
            reg = %r{#{query}}
            assigns(:beers).each do |beer|
              beer.name.should match reg
            end
          end

        end
      end
    end
  end
end

