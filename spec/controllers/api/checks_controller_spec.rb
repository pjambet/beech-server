require 'spec_helper'

describe Api::ChecksController do
  let(:user) { create :user, :with_checks }

  context 'when not logged in' do
    describe "GET 'index'" do
      it 'should respond with unauthorized' do
        get :index, format: 'json'
        expect(response.code).to eq('401')
      end
    end
    describe "POST 'create'" do
      it 'should respond with unauthorized' do
        post :create, format: 'json'
        expect(response.code).to eq('401')
      end
    end
  end

  context 'when logged in' do
    before(:each) { sign_in user }

    describe "GET index" do

      it "assigns all checks to @checks" do
        get :index, user_id: user, format: 'json'
        ['Kronembourg', 'Stella Artois', 'Guiness'].each do |b|
          assigns(:checks).map(&:name).should include b
        end
      end
    end

    describe "POST create" do

      let(:attributes) { attributes_for :check_attributes }

      it "creates a check" do
        expect {
          post :create, check: attributes, format: 'json'
        }.to change{ Check.count }.by(1)
      end
    end
  end

end

