require 'spec_helper'

describe Admin::BeersController do
  render_views

  let(:beer) { create :beer }

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

  describe "GET 'edit'" do
    let(:get_request) { ->{ get :edit, id: beer } }

    context 'when logged in' do
      before(:each) do
        sign_in user
        get_request.call
      end

      context 'as an admin' do
        let(:user) { create :user, :admin }

        it 'should assign the beer' do
          expect(assigns(:beer)).to eq(beer)
        end
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
        it 'redirect to the index' do
          response.should redirect_to(admin_beers_path)
        end

        it 'should assign the beer' do
          expect(assigns(:beer)).to eq(beer)
        end

        it 'should send and email' do
          expect{put_request.call}.to change{ActionMailer::Base.deliveries.count}.by(1)
        end
      end
    end
  end
end

