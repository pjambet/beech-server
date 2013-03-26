require 'spec_helper'

describe Admin::UsersController do
  render_views

  it_should_behave_like 'an admin controller', {
    index: :get,
    new: :get,
    create: :post,
    edit: {method: :get, params: {id: 1}},
    update: {method: :put, params: {id: 1}},
    destroy: {method: :delete, params: {id: 1}},
  }

  describe "GET 'index'" do
    context 'when logged is as an admin' do
      let(:user) { create :user, :admin }
      before(:each) do
        @users = 2.times.map { create :user }
      @users << user
        sign_in user
        get :index
      end

      it { expect(assigns(:users)).to match_array(@users)}
    end
  end

  describe "GET 'new'" do
    context 'when logged is as an admin' do
      let(:user) { create :user, :admin }
      before(:each) do
        sign_in user
        get :new
      end

      it { expect(assigns(:user)).not_to be_nil }
      it { expect(assigns(:user)).to be_new_record }
    end
  end
end

