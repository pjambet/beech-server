require 'spec_helper'

describe Api::ChecksController do
  let(:user) { create :user, :with_checks }

  it_should_behave_like 'an api controller', {
    create: :post,
  }

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

