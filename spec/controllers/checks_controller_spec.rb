require 'spec_helper'

describe ChecksController do
  let(:user) { create :user, :with_checks }

  describe "GET index" do

    it "assigns all checks to @checks" do
      get :index, user_id: user.id
      ['Kronembourg', 'Stella Artois', 'Guiness'].each do |b|
        assigns(:checks).map(&:name).should include b
      end
    end
  end

  describe "POST create" do

    let(:attributes) { attributes_for :check_attributes }

    it "creates a check" do
      post :create, user_id: user.id, check: attributes
      assert assigns(:check).present?
    end
  end

end

