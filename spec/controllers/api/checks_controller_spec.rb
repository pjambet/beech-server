require 'spec_helper'

describe Api::ChecksController do
  let(:user) { create :user, :with_checks }

  context 'when not logged in' do
    describe "POST 'create'" do
      it 'should respond with unauthorized' do
        post :create, format: 'json'
        expect(response.code).to eq('401')
      end
    end
  end

  context 'when logged in' do
    before(:each) { sign_in user }

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

