require 'spec_helper'

describe Admin::BeersController do
  let(:beer) { create :beer }
  describe "GET 'index'" do
    let(:get_request) { ->{ get :index } }

    context 'when not logged in' do
      it 'should redirect to sign_in form' do
        get_request.call
        expect(response.code).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:each) do
        sign_in user
        get_request.call
      end
      context 'as a regular user' do
        let(:user) { create :user }
        it 'should redirect to sign_in page' do
          response.should redirect_to(new_user_session_path)
        end
      end

      context 'as an admin' do
        let(:user) { create :user, :admin }
        it 'should respond with success' do
          expect(response.code).to eq('200')
        end
      end
    end
  end

  describe "GET 'edit'" do
    let(:get_request) { ->{ get :edit, id: beer } }
    context 'when not logged in' do
      it 'should redirect to sign_in form' do
        get_request.call
        expect(response.code).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:each) do
        sign_in user
        get_request.call
      end
      context 'as a regular user' do
        let(:user) { create :user }
        it 'should redirect to sign_in page' do
          response.should redirect_to(new_user_session_path)
        end
      end

      context 'as an admin' do
        let(:user) { create :user, :admin }
        it 'should respond with success' do
          expect(response.code).to eq('200')
        end

        it 'should assign the beer' do
          expect(assigns(:beer)).to eq(beer)
        end
      end
    end
  end

  describe "PUT 'accept'" do
    let(:put_request) { ->{ put :accept, id: beer } }
    context 'when not logged in' do
      it 'should redirect to sign_in form' do
        put_request.call
        expect(response.code).to redirect_to(new_user_session_path)
      end
    end

    context 'when logged in' do
      before(:each) do
        sign_in user
        put_request.call
      end
      context 'as a regular user' do
        let(:user) { create :user }
        it 'should redirect to sign_in page' do
          response.should redirect_to(new_user_session_path)
        end
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

