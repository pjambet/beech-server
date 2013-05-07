require 'spec_helper'

describe Api::LikesController do
  it_should_behave_like 'an api controller', {
    index: {method: :get, params: {event_id: 1}},
    create: {method: :post, params: {event_id: 1}},
  }

  let(:user) { create :user }

  describe "GET 'index'" do
    let(:event) { create :event }
    let(:likes) { 2.times.map { create :like, event: event } }
    let(:other_likes) { 2.times.map { create :like } }
    before(:each) do
      sign_in user
      likes # just 'touch' the likes
      other_likes
      get :index, event_id: event, format: :json
    end

    it { expect(assigns(:likes)).to match_array(likes) }
    it { expect(assigns(:likes)).not_to match_array(other_likes) }
  end

  describe "POST 'create'" do
    let(:event) { create :event }
    let(:post_request) {
      -> { post :create, event_id: event, format: :json }
    }
    before(:each) do
      sign_in user
    end

    it { expect{post_request.call}.to change{Like.count}.by(1) }
  end

  describe "DELETE 'destroy'" do
    let(:event) { create :event }
    let(:delete_request) {
      -> { delete :destroy, event_id: event, format: :json }
    }
    before(:each) do
      sign_in user
      user.like(event)
    end

    it { expect{delete_request.call}.to change{Event.count}.by(0) }
    it { expect{delete_request.call}.to change{Like.count}.by(-1) }
  end
end
