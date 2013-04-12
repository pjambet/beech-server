require 'spec_helper'

describe Api::CommentsController do
  it_should_behave_like 'an api controller', {
    index: {method: :get, params: {event_id: 1}},
    create: {method: :post, params: {event_id: 1}},
    destroy: {method: :delete, params: {id: 1, event_id: 1}},
  }

  let(:user) { create :user }

  describe "GET 'index'" do
    let(:event) { create :event }
    let(:comments) { 2.times.map { create :comment, event: event } }
    let(:other_comments) { 2.times.map { create :comment } }
    before(:each) do
      sign_in user
      comments # just 'touch' the comments
      other_comments
      get :index, event_id: event, format: :json
    end

    it { expect(assigns(:comments)).to eq(comments) }
    it { expect(assigns(:comments)).not_to match_array(other_comments) }
  end

  describe "POST 'create'" do
    let(:event) { create :event }
    let(:params) { { content: "Hey it kicks ass" } }
    let(:post_request) {
      -> { post :create, event_id: event, format: :json, comment: params }
    }
    before(:each) do
      sign_in user
      post_request.call
    end

    it { expect{post_request.call}.to change{Comment.count}.by(1) }
  end

  describe "DELETE 'destroy'" do
    let(:event) { create :event }
    let(:comment) { create :comment, user: user, event: event }
    let(:delete_request) {
      -> { delete :destroy, id: comment, event_id: event, format: :json }
    }
    before(:each) do
      sign_in user
      comment
    end

    it { expect{delete_request.call}.to change{Event.count}.by(0) }
    it { expect{delete_request.call}.to change{Comment.count}.by(-1) }
  end
end
