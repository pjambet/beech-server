require 'spec_helper'

describe Users::RegistrationsController do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  let(:user) { create :user }
  context 'when not logged in' do
    describe "GET 'new'" do
      before(:each) { get :new }
      it 'should respond with success' do
        response.response_code.should == 200
      end
    end

    describe "POST 'create'" do
      subject(:do_request) { post :create, parameters }

      context 'with good parameters' do
        let(:parameters) do
          {
            user: {
              nickname: 'nickname',
              email: 'foo@bar.com',
              password: 'password',
            }
          }
        end

        context 'html' do
          subject(:do_request) { post :create, parameters.merge(format: 'html') }

          it 'should respond with success' do
            response.response_code.should == 200
          end
        end

        context 'json' do
          subject(:do_request) { post :create, parameters.merge(format: 'json') }

          it 'should response with created' do
            do_request
            response.response_code.should == 201
          end
        end

        it 'should create a user' do
          expect{do_request}.to change{User.count}.by(1)
        end

        it 'should send a mail' do
          expect{do_request}.to change{ActionMailer::Base.deliveries.count}.by(1)
        end
      end

      context 'with bad parameters' do
        let(:parameters) { {foo: 'bar'} }
        it 'should respond with success' do
          do_request
          response.response_code.should == 200
        end

        it 'should not create a user' do
          expect{do_request}.to change{User.count}.by(0)
        end

        it 'should not send any mails' do
          expect{do_request}.to change{ActionMailer::Base.deliveries.count}.by(0)
        end
      end
    end
  end

  context 'when logged in' do
    before(:each) do
      sign_in user
      get :new
    end

    it 'should redirect to users#show' do
      response.should redirect_to(user_path(user))
    end
  end
end

