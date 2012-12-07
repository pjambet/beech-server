require 'spec_helper'

describe BeersController do
  describe "GET index" do
    before(:each) { 25.times.map { create :beer } }

    context 'without query' do
      before(:each) do
        get :index
      end

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
        assigns(:beers).each do |beer|
          beer.name.should match %r{#{query}}
        end
      end

    end
  end
end

