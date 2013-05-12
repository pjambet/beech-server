require 'spec_helper'

describe Admin::BadgesController do
  render_views
  let(:user) { create :user, :admin }

  it_should_behave_like 'an admin controller', {
    index: :get,
    new: :get,
    create: :post,
    edit: {method: :get, params: {id: 1}},
    update: {method: :put, params: {id: 1}},
    destroy: {method: :delete, params: {id: 1}},
  }

  describe "GET 'index'" do
    before(:each) do
      @badges = 2.times.map { create :badge }
      sign_in user
      get :index
    end

    it { expect(assigns(:badges)).to match_array(@badges) }
  end

  describe "GET 'new'" do
    before(:each) do
      sign_in user
      get :new
    end

    it { expect(assigns(:badge)).to be_a(Badge) }
  end

  describe "GET 'edit'" do
    let(:badge) { create :badge }
    before(:each) do
      sign_in user
      get :edit, id: badge
    end

    it { expect(assigns(:badge)).to eq(badge) }
  end

  describe "POST 'create'" do
    before(:each) do
      sign_in user
    end
    let(:post_request) { ->{ post :create, badge: badge_params } }
    let(:badge_params) { attributes_for :badge }

    it { expect{post_request.call}.to change{Badge.count}.by(1) }
  end

  describe "PUT 'update'" do
    before(:each) do
      sign_in user
      put :update, id: badge, badge: params
    end
    let(:params) { {name: 'So French'} }
    subject(:badge) { create :badge }

    it { badge.reload.name.should eq('So French') }
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      sign_in user
      delete :destroy, id: badge
    end
    let(:badge) { create :badge }

    it { response.should redirect_to(admin_badges_path) }
    it { expect{Badge.find(badge.id)}.to(
      raise_error(ActiveRecord::RecordNotFound)) }
  end
end

