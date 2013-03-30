require 'spec_helper'

describe Admin::UsersController do
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
    context 'when logged is as an admin' do
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
      before(:each) do
        sign_in user
        get :new
      end

      it { expect(assigns(:user)).not_to be_nil }
      it { expect(assigns(:user)).to be_new_record }
    end
  end

  describe "GET 'edit'" do
    let(:edited_user) { create :user }
    before(:each) do
      sign_in user
      get :edit, id: edited_user
    end

    it { expect(assigns(:user)).to eq(edited_user) }
  end

  describe "POST 'create'" do
    before(:each) do
      sign_in user
    end
    let(:post_request) { ->{ post :create, user: params } }
    let(:params) { attributes_for :user }

    it { expect{post_request.call}.to change{User.count}.by(1) }
  end

  describe "PUT 'update'" do
    before(:each) do
      sign_in user
      put :update, id: updated_user, user: params
    end
    let(:params) {
      {
        nickname: 'jean jacques',
        password: '',
        password_confirmation: '',
        email: updated_user.email
      }
    }
    subject(:updated_user) { create :user }

    it { updated_user.reload.nickname.should eq('jean jacques') }
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      sign_in user
      delete :destroy, id: deleted_user
    end
    let(:deleted_user) { create :user }

    it { response.should redirect_to(admin_users_path) }
    it { expect{User.find(deleted_user.id)}.to(
      raise_error(ActiveRecord::RecordNotFound)) }
  end
end

