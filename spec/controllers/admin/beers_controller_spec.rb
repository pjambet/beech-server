require 'spec_helper'

describe Admin::BeersController do
  render_views

  let(:beer) { create :beer }
  let(:user) { create :user, :admin }

  it_should_behave_like 'an admin controller', {
    index: :get,
    new: :get,
    create: :post,
    edit: {method: :get, params: {id: 1}},
    update: {method: :put, params: {id: 1}},
    accept: {method: :put, params: {id: 1}},
    reject: {method: :put, params: {id: 1}},
    destroy: {method: :delete, params: {id: 1}},
  }

  describe "GET 'index'" do
    before(:each) do
      @beers = 2.times.map { create :beer }
      @rejected = 2.times.map { create :beer, :rejected }
      @suggested = 2.times.map { create :beer, :suggested }
      sign_in user
      get :index
    end

    it { expect(assigns(:beers)).to match_array(@beers) }
    it { expect(assigns(:rejected)).to match_array(@rejected) }
    it { expect(assigns(:suggested)).to match_array(@suggested) }
  end

  describe "GET 'new'" do
    before(:each) do
      sign_in user
      get :new
    end

    it { expect(assigns(:beer)).to be_a(Beer) }
  end

  describe "GET 'edit'" do
    let(:get_request) { ->{ get :edit, id: beer } }

    context 'when logged in' do
      before(:each) do
        sign_in user
        get_request.call
      end

      context 'as an admin' do
        it 'assigns the beer' do
          expect(assigns(:beer)).to eq(beer)
        end
      end
    end
  end

  describe "PUT 'update'" do
    let(:put_request) { ->{ put :update, id: beer, beer: params } }

    context 'when logged in' do
      before(:each) do
        sign_in user
        put_request.call
      end

      context 'as an admin' do
        subject(:beer) { create :beer, added_by: user }
        let(:params) { {country: 'malaysia'} }

        it { response.should redirect_to(admin_beers_path) }
        it { expect(assigns(:beer)).to eq(beer) }
        it { beer.reload.country.should eq('malaysia') }
      end
    end
  end

  describe "PUT 'accept'" do
    let(:put_request) { ->{ put :accept, id: beer } }

    context 'when logged in' do
      before(:each) do
        sign_in user
        put_request.call
      end

      context 'as an admin' do
        let(:user) { create :user, :admin }
        let(:beer) { create :beer, added_by: user }

        it { response.should redirect_to(admin_beers_path) }
        it { expect(assigns(:beer)).to eq(beer) }
        it { beer.reload.accepted.should be_true }
        it 'should send and email' do
          expect{put_request.call}.to(
            change{ActionMailer::Base.deliveries.count}.by(1))
        end
      end
    end
  end

  describe "PUT 'reject'" do
    let(:put_request) { ->{ put :reject, id: beer } }

    context 'when logged in' do
      before(:each) do
        sign_in user
        put_request.call
      end

      context 'as an admin' do
        let(:user) { create :user, :admin }
        let(:beer) { create :beer, added_by: user }

        it { response.should redirect_to(admin_beers_path) }
        it { expect(assigns(:beer)).to eq(beer) }
        it { beer.reload.accepted.should be_false }
      end
    end
  end

  describe "DELETE 'destroy'" do
    let(:delete_request) { ->{ delete :destroy, id: beer } }

    context 'when logged in' do
      before(:each) do
        sign_in user
        delete_request.call
      end

      context 'as an admin' do
        let(:user) { create :user, :admin }
        let(:beer) { create :beer, added_by: user }

        it { response.should redirect_to(admin_beers_path) }
        it { expect{Beer.find(beer.id)}.to(
          raise_error(ActiveRecord::RecordNotFound)) }
      end
    end
  end
end

